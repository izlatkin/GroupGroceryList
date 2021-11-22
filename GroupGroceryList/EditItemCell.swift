//
//  EditItemCell.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 22.11.2021.
//

import UIKit

protocol EditItemCellDelegate: AnyObject{
    func removeItem(with itemCell:EditItemCell)
}

class EditItemCell: UITableViewCell {
    weak var delegate: EditItemCellDelegate?

    @IBOutlet weak var ItemImage: UIImageView!
    
    @IBOutlet weak var ItemName: UILabel!
    
    @IBOutlet weak var descriptionName: UILabel!
    
    @IBOutlet weak var removeButtom: UIButton!
    
    @IBAction func removeItem(_ sender: Any) {
        let name = (ItemName.text ?? "") as String
        print("Removing \(name) added")
        delegate?.removeItem(with: self)
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
