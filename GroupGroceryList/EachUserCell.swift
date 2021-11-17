//
//  EachUserCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

protocol UserCellDelegate: AnyObject {
    func TappedCellbtn(with user: PFObject)         //can pass as much data as we want here to get accessed where called
}                                                   //somewhat analogous to interfaces and Adapters/RV in android

class EachUserCell: UITableViewCell {

    weak var delegate: UserCellDelegate?
    private var user: PFObject!
    
    @IBOutlet weak var ivProfilePic: UIImageView!
    
    @IBOutlet weak var TLUserName: UILabel!
    
    @IBOutlet weak var btnSelectUser: UIButton!
    
    @IBAction func btnSelectUser(_ sender: Any) {
 
        //This code runs to cause an immediate animation but isn't based on data-
        // Whenever a cell loads, it is checked to see if user already added and that is what determines what is shown on screen when scrolling and viewing cells
        //That code is in AddUserController, needed both of these pieces to work because since reusing cells-the code below was not enough on its own and the code in AddUserController couldn't do the animations when clicked
        
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
