//
//  EachUserCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

protocol UserCellDelegate: AnyObject {
    func TappedCellbtn(with user: PFObject)
}

class EachUserCell: UITableViewCell {

    weak var delegate: UserCellDelegate?
    private var user: PFObject!
    
    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBOutlet weak var TLUserName: UILabel!
    
    @IBOutlet weak var btnSelectUser: UIButton!
    
    
    
    @IBAction func btnSelectUser(_ sender: Any) {
        
        print("here")
        
        if btnSelectUser.currentTitle == "Add to List"{
            btnSelectUser.setTitle("Remove", for: .normal)
            btnSelectUser.setTitleColor(UIColor.red, for: .normal)
        }
        else{
            btnSelectUser.setTitle("Add to List", for: .normal)
            btnSelectUser.setTitleColor(UIColor.systemBlue, for: .normal)
        }
        
        
        
    
        delegate?.TappedCellbtn(with: user)
    }
    
    func configure(with user: PFObject){
        self.user = user
      
    }
    
    
    override func awakeFromNib() {      //views not loaded yet when this runs
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
