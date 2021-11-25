//
//  NotificationsViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/24/21.
//

import UIKit
import Parse

class NotificationsViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
  
    @IBOutlet weak var TVNotifications: UITableView!
    var AddedToListNotifications:[PFObject]=[]      //will store the value passed from segue, possibly nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TVNotifications.dataSource = self
        TVNotifications.delegate = self
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AddedToListNotifications != nil{
            return self.AddedToListNotifications.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVNotifications.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell

        if self.AddedToListNotifications != nil{
            let sendername = AddedToListNotifications[indexPath.row]["SenderName"] as! String
            cell.TLMessage.text = sendername + " added you to a shopping list!"
            let file=AddedToListNotifications[indexPath.row]["SenderProfilePic"] as! PFFileObject
            let urlstring=file.url!
            let url=URL(string: urlstring)!
            cell.IVSenderProfilePic.af_setImage(withURL: url)
            if AddedToListNotifications[indexPath.row]["ReceiverHasRead"] as! Bool == false{
                cell.IVRedDot.isHidden = false
                cell.btnConfirm.isHidden = false
            }
            else{
                cell.IVRedDot.isHidden = true
                cell.btnConfirm.isHidden = true
            }
                
            cell.configure(with: AddedToListNotifications[indexPath.row] )
            cell.delegate = self
            
        }
        
        return cell
    }
    

    
    

    

}

extension NotificationsViewController: NotificationCellDelegate{
    func TappedCellbtn(with TheNotification: PFObject){
        TheNotification["ReceiverHasRead"] = true
        TheNotification.saveInBackground { success, Error in
            if success{
                self.TVNotifications.reloadData()
            }
            else{
                print("failed to update read message status on back4app")
            }
        }
        
    }
    
}
