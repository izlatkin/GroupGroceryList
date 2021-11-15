//
//  HomeViewController.swift
//  GroupGroceryList
//
//  Created by Greg Garman on 11/5/21.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var TVLists: UITableView!
    
    var AllShoppingList:[PFObject]=[]
    var AllMyLists:[PFObject]=[]
    var MyListsMemberCount:[Int]=[]
    var CreatorNames:[String]=[]
    
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

        return cell
    }
    

    @IBAction func btnCreateList(_ sender: Any) {
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
    

   

}
