//
//  EachAddedUserCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/6/21.
//

import UIKit

class EachAddedUserCell: UITableViewCell {

    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBOutlet weak var TLusername: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
