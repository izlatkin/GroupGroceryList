//
//  EditItemCell.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 22.11.2021.
//

import UIKit

class EditItemCell: UITableViewCell {

    @IBOutlet weak var ItemImage: UIImageView!
    
    @IBOutlet weak var ItemName: UILabel!
    
    @IBOutlet weak var descriptionName: UILabel!
    
    @IBOutlet weak var removeButtom: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
