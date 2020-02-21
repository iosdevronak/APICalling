//
//  UserTableViewController.swift
//  TableView
//
//  Created by Ronak Patel on 19/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    

  var cl = ClientRequest()
    var info = [UserDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
          
        
        cl.request(url: "https://jsonplaceholder.typicode.com/posts", method: .GET, completion: {
            response , error in
           
            let userSerialise = try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
            self.info = try! JSONDecoder().decode([UserDetails].self, from: userSerialise)
            DispatchQueue.main.async{
            self.tableView.reloadData()
            }
        })
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

        navigationController?.navigationBar.barTintColor = .black
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return info.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cellIdentifier = "user"
           guard  let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? UserTableViewCell
          else{
              fatalError("Error whhile calling cell ")
          }
        let details = info[indexPath.row]
        cell.id.text = "\(details.id)"
        cell.title.text = details.title
        
           return cell
       }
    
    
       
      override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
           
            let editUser = self.info[indexPath.row]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc =  storyBoard.instantiateViewController(withIdentifier: "edit") as! UserViewController
            vc.userDetails = editUser
            self.present(vc, animated: true, completion: nil)
            
        })
        
        //Delete Action
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            //posts/1
             let deleteUser = self.info[indexPath.row]
            self.cl.request(url: "https://jsonplaceholder.typicode.com/posts/\(deleteUser.id)", method: .DELETE, completion: {
                response , error in
                _ = try! JSONSerialization.data(withJSONObject: response as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
                 self.info.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            
        })
        
        editAction.backgroundColor = UIColor.blue
        deleteAction.backgroundColor = UIColor.red
        return [editAction , deleteAction]
    
    }
}
