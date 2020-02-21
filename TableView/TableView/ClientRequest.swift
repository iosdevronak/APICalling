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
                let dataString = String(data: data1, encoding: .utf8)

                request.httpBody = data1
            }
            request.httpMethod = method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request, completionHandler: { (data , response , error) in
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



//suppose if we want to store any token receieved after login then. 
//Store it using User default:  UserDefaults.standard.set(self.authtoken, forKey: "access-token")
//And then add bellow shown lines in ClientRequest class.
// let token  = UserDefaults.standard.string(forKey: "access-token")
//  request.setValue(token, forHTTPHeaderField: "auth-token")
