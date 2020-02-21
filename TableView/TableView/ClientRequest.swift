//
//  ClientRequest.swift
//  TableView
//
//  Created by Ronak Patel on 19/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import Foundation

class ClientRequest : Codable {
    enum Method: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    func request(url:String, method: Method, params: [String : Any]? = nil , completion: @escaping (Any?, String?)->()){
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            if  let resParam = params {
                let data1 = try! JSONSerialization.data(withJSONObject: resParam, options: JSONSerialization.WritingOptions.prettyPrinted)
                //print("JSONSerialization\(data1)")
                let dataString = String(data: data1, encoding: .utf8)

                request.httpBody = data1
            }
            request.httpMethod = method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request, completionHandler: { (data , response , error) in
           //     print("URLSession data \(data)")
                if let  resData = data{
                    if let responseData = response as? HTTPURLResponse {
                        print(responseData.statusCode)
                    }
                    if let json = try? JSONSerialization.jsonObject(with: resData, options: .mutableContainers) {
                  
                        completion(json, nil)
                    }
                    else {
                        completion(nil,"Can not parse to JSON")
                    }
                }
                else{
                    completion(nil, error?.localizedDescription ?? "")
                    print(error?.localizedDescription)
                }
            }).resume()
        }
    }
}

