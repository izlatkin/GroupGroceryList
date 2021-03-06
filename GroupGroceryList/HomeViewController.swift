//
//  HomeViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    let defaults = UserDefaults.standard
   
    @IBOutlet weak var TVLists: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var btnNotificationBell: UIBarButtonItem!
    
    
    
    
    var AllShoppingList:[PFObject]=[]
    var AllMyLists:[PFObject]=[]
    var MyListsMemberCount:[Int]=[]
    var CreatorNames:[String]=[]
    var ListNotifications:[PFObject]=[]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllMyLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TVLists.dequeueReusableCell(withIdentifier: "EachListCell") as! EachListCell
        let ListName = AllMyLists[indexPath.row]["ListName"] as! String
        cell.TLListName.text=ListName
        cell.CreatorName.text = "Created By " + CreatorNames[indexPath.row]
        let count=MyListsMemberCount[indexPath.row]
        cell.TLListMemberCount.text = "\(count) Members"
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            cell.contentView.backgroundColor = UIColor.white
            cell.TLListName.textColor = UIColor.black
            cell.CreatorName.textColor = UIColor.black
            cell.TLListMemberCount.textColor = UIColor.black
        }
        if (modeValue == 1)
        {
            cell.contentView.backgroundColor = UIColor.black
            cell.TLListName.textColor = UIColor.white
            cell.CreatorName.textColor = UIColor.white
            cell.TLListMemberCount.textColor = UIColor.white
        }
       
            
        return cell
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      if segue.destination is NotificationsController{
  //          let VC = segue.destination as? NotificationsController
   //         VC?.AddedToListNotifications = ListNotifications
   //     }
//    }
    
    @IBAction func btnSeeNotifications(_ sender: Any) {
        
        self.performSegue(withIdentifier: "SeeNotificationsSegue", sender: nil)
        
    }
    
    @IBAction func btnCreateNewList(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateListSegue", sender: nil)
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        TVLists.delegate=self
        TVLists.dataSource=self
        
        var UserArray:[PFObject]=[]
        var count=0
        
        let query = PFQuery(className: "ShoppingList")
        query.findObjectsInBackground { TheLists, Error in
            if TheLists != nil{
                self.AllShoppingList = TheLists!
                
                for list in self.AllShoppingList{
                    UserArray = list["UserList"] as! [PFObject]
                    for user in UserArray{
                        
                        if user.objectId == PFUser.current()?.objectId{
                            self.AllMyLists.append(list)
                            self.MyListsMemberCount.append(UserArray.count)
                            self.CreatorNames.append(list["CreatorName"] as! String)
                        }
                        
                    }
                    
                }
                
                self.TVLists.reloadData()
            }
        }
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {        //runs everytime screen loads
        super.viewWillAppear(animated)
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            self.view.backgroundColor = UIColor.white
            titleLabel.textColor = UIColor.black
            self.TVLists.backgroundColor = UIColor.white
           
           
         
        }
        if (modeValue == 1)
        {
            self.view.backgroundColor = UIColor.black
            titleLabel.textColor = UIColor.white
            self.TVLists.backgroundColor = UIColor.black
          
            
          

            
        }
        self.TVLists.reloadData()
        
        //querying and checking for notifications below
        self.btnNotificationBell.setBackgroundImage(UIImage(named:"thisbell"), for: UIControl.State.normal, barMetrics: UIBarMetrics.default)
        let NotificationQuery = PFQuery(className: "AddedToListNotification")
        NotificationQuery.whereKey("ReceiverID", contains: PFUser.current()?.objectId)
        NotificationQuery.findObjectsInBackground { List, Error in
            
            self.ListNotifications = List!  //if null in next VC, won't load anything
            if List != nil {
                    for notification in self.ListNotifications{
                        if (notification["ReceiverHasRead"] as! Bool == false){
                            self.btnNotificationBell.setBackgroundImage(UIImage(named:"thisbelldot"), for: UIControl.State.normal, barMetrics: UIBarMetrics.default)
                        }
                        
                    }
            }
            
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is NotificationsViewController{
                  let VC = segue.destination as? NotificationsViewController
                  VC?.AddedToListNotifications = ListNotifications
              }
        
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Loading up the details screen")
        
        //find the selected MyList
        let isWasCell = (sender is UITableViewCell ? true : false)
        if isWasCell{
            let cell = try sender as! UITableViewCell
            let indexPath = TVLists.indexPath(for: cell)!
            let ListName = AllMyLists[indexPath.row]["ListName"] as! String
            print("List name \(ListName)")
            let SelectedMyList = AllMyLists[indexPath.row]
            let CreatorName = CreatorNames[indexPath.row]
            let detailsViewController = segue.destination as! MyListViewController
            detailsViewController.SelectedMyList = SelectedMyList
            detailsViewController.CreatorName = CreatorName
            detailsViewController.MyListsMemberCount = MyListsMemberCount[indexPath.row]
        }
//        catch {
//
//        }

//        let movie = movies[indexPath.row]
//
//        //pass the selected movie to the delaild view controller
//        let detailsViewController = segue.destination as! MoviesDetailsViewController
//        detailsViewController.movie = movie
//
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
   

}
