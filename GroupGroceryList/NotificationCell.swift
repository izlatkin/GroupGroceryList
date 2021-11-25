//
//  NotificationCell.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/24/21.
//

import UIKit
import Parse

protocol NotificationCellDelegate: AnyObject {
    func TappedCellbtn(with TheNotification: PFObject)
}

class NotificationCell: UITableViewCell {

    @IBOutlet weak var TLMessage: UILabel!
    @IBOutlet weak var IVSenderProfilePic: UIImageView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var IVRedDot: UIImageView!
    
    
    weak var delegate: NotificationCellDelegate?
    private var TheNotification: PFObject!
    
    @IBAction func btnConfirmation(_ sender: Any) {
        if btnConfirm.currentTitle == "Got It!"{
            btnConfirm.isHidden = true
            IVRedDot.isHidden = true
        }
        //need to change the hasread status to true on back for app at this moment
        
        delegate?.TappedCellbtn(with: TheNotification)
    }
    
    func configure(with TheNotification: PFObject){
        self.TheNotification = TheNotification
      
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


