//
//  EachListCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/14/21.
//

import UIKit

class EachListCell: UITableViewCell {

    @IBOutlet weak var TLListName: UILabel!
    
    @IBOutlet weak var CreatorName: UILabel!
    
    @IBOutlet weak var TLListMemberCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
