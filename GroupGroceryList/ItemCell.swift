//
//  ItemCell.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 07.11.2021.
//

import UIKit

protocol ItemCellDelegate: AnyObject{
    func AddItem(with itemCell:ItemCell)
}

class ItemCell: UITableViewCell {
    weak var delegate: ItemCellDelegate?
    
    static let identifier = "ItemCell"
    
    var listname = ""

    @IBOutlet weak var ItemName: UILabel!
    
    @IBOutlet weak var DescriptionLabble: UILabel!
    
    @IBOutlet weak var ImageOfItem: UIImageView!
    @IBOutlet weak var ItemCellAddbuttom: UIButton!
    
    @IBAction func AddItem(_ sender: Any) {
        let name = (ItemName.text ?? "") as String
        print("Item \(name) added")
        delegate?.AddItem(with: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    static func nub() -> UINib{
//        return UINib(nibName: "ItemCell", bundle: nil)
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
