//
//  MyListViewController.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 21.11.2021.
//

import UIKit
import Parse

class MyListViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
    
    var listOfItems:[PFObject]=[]
    
    @IBOutlet weak var ItemsTable: UITableView!
    
    var SelectedMyList:PFObject?
    var CreatorName:String?
    var MyListsMemberCount:Int?
    
    @IBOutlet weak var ListName: UILabel!
    @IBOutlet weak var CreatedBy: UILabel!
    var currentListID = ""

    

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemsTable.delegate=self
        ItemsTable.dataSource=self
        
        print("[MyListViewController]List Name: \(SelectedMyList?["ListName"])")
        print("\(MyListsMemberCount) Members")
        print("Created By \(CreatorName)")
        //print("Created By : \(SelectedMyList["ListName"])")
        ListName.text = SelectedMyList?["ListName"] as! String
        CreatedBy.text = CreatorName
        //get list ID
        let defaults = UserDefaults.standard
        let query = PFQuery(className: "ShoppingList")
        query.includeKeys(["objectID", "UserList", "ListName"])
        query.whereKey("ListName", equalTo: ListName.text)
        do{
            let results = try query.getFirstObject()
            print("results:")
            print(results)
            print("objectId:")
            print(results.objectId)
            currentListID = results.objectId ?? ""
            defaults.set(currentListID , forKey: "currentListID")
        }catch{}
        
        let query2 = PFQuery(className: "ItemsTable")
        query2.limit = 20
        query2.whereKey("ListID", equalTo: currentListID)
        query2.findObjectsInBackground { TheLists, Error in
            if TheLists != nil{
                self.listOfItems = TheLists!
                print("ListOfItems from MyListViewController")
                print(self.listOfItems)
                print("==========================")
                print(self.listOfItems.count)
                
                self.ItemsTable.reloadData()
            }
        }
        self.ItemsTable.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditItemCell") as! EditItemCell
        var itemName = listOfItems[indexPath.row]["ItemName"] as! String
        cell.ItemName.text = itemName
        var DescriptionName = listOfItems[indexPath.row]["Description"] as! String
        cell.descriptionName.text = DescriptionName
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
