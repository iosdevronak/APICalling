//
//  UserViewController.swift
//  TableView
//
//  Created by Ronak Patel on 20/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")

import UIKit

class UserViewController: UIViewController  {

    @IBOutlet weak var userID: UITextField!
    @IBOutlet weak var userTitle: UITextField!
    @IBOutlet weak var userBody: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    var userDetails : UserDetails?
    let clientReq = ClientRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
              if userDetails != nil{
                     btn.setTitle("Edit", for: .normal)
                     }
                     else{
                         btn.setTitle("Save", for: .normal)
                    }
        
          if let resUser = userDetails {
            userID.text = "\(resUser.userId)"
            userTitle.text = resUser.title
            userBody.text = resUser.body
            }
        
    }
    @IBAction func btnAction(_ sender: UIButton) {
        let uID = userID.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let uTitle = userTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let uBody = userBody.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let parameter = ["userId": uID , "title": uTitle , "body": uBody]
        
        switch sender {
        case btn:
                    if let resUser = userDetails{
                  
                clientReq.request(url: "https://jsonplaceholder.typicode.com/posts/\(resUser.id)", method: .PUT, params: parameter, completion: {
                    response , error in
                  
                })
            
            }
            else{
                clientReq.request(url: "https://jsonplaceholder.typicode.com/posts", method: .POST, params: parameter, completion: {
                    response , error in
                })

            }

        default:
            print("break")
            return
        }
    }

}
