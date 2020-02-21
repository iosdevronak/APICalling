//
//  DemoTableViewCell.swift
//  TableView
//
//  Created by Ronak Patel on 20/02/20.
//  Copyright © 2020 Ronak Patel. All rights reserved.
//

import UIKit

class DemoTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    
    // MARK:- Properties
    var cons: String?
    {
        didSet
        {
            self.updateUI()
        }
    }
    
    var controller_id: String? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension DemoTableViewCell
{
    fileprivate func updateUI()
    {
        if let _cons = cons
        {
            if self.controller_id == "DemoTableViewController"
            {
                self.name?.text = _cons
            }
            else
            {
                self.number?.text = _cons
            }
            
          
        }
    }
}
