//
//  EachUserCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit

class EachUserCell: UITableViewCell {

    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBOutlet weak var TLUserName: UILabel!
    
    @IBAction func btnSelectUser(_ sender: Any) {
        print("clicking")
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
