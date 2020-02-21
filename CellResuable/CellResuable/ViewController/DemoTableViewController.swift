//
//  DemoTableViewController.swift
//  TableView
//
//  Created by Ronak Patel on 20/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController {
    var db:DBHelper = DBHelper()
    var cName = [ContactName]()
//    let contacts = [
//        "Elon Musk",
//        "Bill Gates",
//        "Tim Cook",
//        "Richard Branson",
//        "Jeff Bezos",
//        "Warren Buffet",
//        "The Zuck",
//        "Carlos Slim",
//        "Bill Gates",
//        "Larry Page",
//        "Harold Finch",
//        "Sergey Brin",
//        "Jack Ma",
//        "Steve Ballmer",
//        "Phil Knight",
//        "Paul Allen",
//        "Woz",
//    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        

       DBCrudNames()

               setUI()
    
    }
    
    func DBCrudNames(){
//
        cName = db.read()
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! DemoTableViewCell
        
        cell.controller_id = "DemoTableViewController"
        //cell.cons = self.contacts[indexPath.row]
        cell.cons = self.cName[indexPath.row].name
           return cell
       }

}

extension DemoTableViewController{
    fileprivate func setUI()
       {
           // To remove the extra spacing
           self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

           // Table configuration
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
           self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
           self.tableView?.estimatedRowHeight = CGFloat(44.0)
        self.tableView?.rowHeight = UITableView.automaticDimension
       }
}


