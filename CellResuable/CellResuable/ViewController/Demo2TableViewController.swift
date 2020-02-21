//
//  Demo2TableViewController.swift
//  CellResuable
//
//  Created by Ronak Patel on 20/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import UIKit

class Demo2TableViewController: UITableViewController {
var db = DBHelperCnumber()
    var cNumber = [ContactNumber]()
    override func viewDidLoad() {
        super.viewDidLoad()
    setUI()
     
       DBCrudNumbers()
        
    }
    
   func DBCrudNumbers(){
//        db.insert(id: 0, number: "+1-201-3141-5926")
//        db.insert(id: 1, number: "+1-202-5358-9793")
//        db.insert(id: 2, number: "+1-203-2384-6264")
//        db.insert(id: 3, number: "+1-204-3383-2795")
//        db.insert(id: 4, number: "+1-205-0288-4197")
//        db.insert(id: 5, number: "+1-206-1693-9937")
//
////        db.deleteByID(id: 100)
        cNumber = db.read()
   }

    // MARK: - Table view data sou+1-217-0955-0582rce

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cNumber.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuse", for: indexPath) as! DemoTableViewCell
        
            cell.controller_id = "Demo2TableViewController"
        cell.cons = self.cNumber[indexPath.row].number
            
               return cell
        
       }
    


}

extension Demo2TableViewController{
    fileprivate func setUI()
       {
           // To remove the extra spacing
           self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)

           // Setting name of controller
           self.title = "Number"

           // Table configuration
        self.tableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
           self.tableView?.tableFooterView = UIView(frame: CGRect.zero)
           self.tableView?.estimatedRowHeight = CGFloat(44.0)
        self.tableView?.rowHeight = UITableView.automaticDimension
       }
}



