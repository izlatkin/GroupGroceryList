//
//  ItemCell.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 07.11.2021.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var ItemName: UILabel!
    
    @IBOutlet weak var DescriptionLabble: UILabel!
    
    @IBOutlet weak var ImageOfItem: UIImageView!
    
    @IBAction func AddItem(_ sender: Any) {
        print("Item \(ItemName.text) added")
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
