//
//  GroupCell.swift
//  GroupGroceryList
//
//  Created by Katy Merritt on 11/8/21.
//

import UIKit

class GroupCell: UITableViewCell {
    

    @IBOutlet weak var groupNameLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var groupListLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
