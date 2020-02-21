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
    
    
    // MARK:- Properties
    var cons: String?
    {
        didSet
        {
            self.updateUI()
        }
    }
    
    
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
            self.name?.text = _cons
        }
    }
}
