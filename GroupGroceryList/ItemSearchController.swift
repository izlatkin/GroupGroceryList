//
//  ItemSearchController.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 07.11.2021.
//

import UIKit
import Parse
import CryptoKit


class ItemSearchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rawItems = [[String:Any]]()
    let defaults = UserDefaults.standard
//    @IBOutlet weak var itemSearchTextField: UITextField!
//    @IBOutlet weak var itemsTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var username = ""
    var currentListName = ""
    public var currentListID = ""
    var listOfUsers:[PFObject]=[]
    
    @IBOutlet weak var itemSearchTextField: UITextField!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    public func getCurrentListID() -> String{
        return currentListID
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //itemsTableView.register(ItemCell.nub(), forCellReuseIdentifier: "ItemCell")
        
        username = PFUser.current()?["username"] as! String
        print("user name: \(username)")
        let defaults = UserDefaults.standard
        currentListName = defaults.string(forKey: "currentList") ?? ""
        print("current list: \(currentListName)")
        
        let query = PFQuery(className: "ShoppingList")
        query.includeKeys(["objectID", "UserList", "ListName"])
        query.whereKey("ListName", equalTo: currentListName)
        do{
            let results = try query.getFirstObject()
            print("results:")
            print(results)
            print("objectId:")
            print(results.objectId)
            currentListID = results.objectId ?? ""
            defaults.set(currentListID , forKey: "currentListID")
        }catch{
            //couldn't get a listname
        }
        
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        self.itemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rawItems.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        var tmp_str = rawItems[indexPath.row]["title"] as! String
        var str = tmp_str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.ItemName.text = str
        tmp_str = rawItems[indexPath.row]["description"] as! String
        str = tmp_str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.DescriptionLabble.text = str
        let imageURL_string = rawItems[indexPath.row]["imageUrl"] as! String
        var imageURL = URL(string: imageURL_string )
        cell.ImageOfItem.af_setImage(withURL: imageURL!)
        cell.isAdded = false
        
        cell.delegate = self
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            cell.contentView.backgroundColor = UIColor.white
            cell.ItemName.textColor = UIColor.black
            cell.DescriptionLabble.textColor = UIColor.black
            
        }
        if (modeValue == 1)
        {
            cell.contentView.backgroundColor = UIColor.black
            cell.DescriptionLabble.textColor = UIColor.white
            cell.ItemName.textColor = UIColor.white
            
        }
       
        
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let modeValue = defaults.double (forKey: "myInt")
        if (modeValue == 0)
        {
            self.view.backgroundColor = UIColor.white
            titleLabel.textColor = UIColor.black
            self.itemsTableView.backgroundColor = UIColor.white
           
           
         
        }
        if (modeValue == 1)
        {
            self.view.backgroundColor = UIColor.black
            titleLabel.textColor = UIColor.white
            self.itemsTableView.backgroundColor = UIColor.black
          
            
          

            
        }
        self.itemsTableView.reloadData()
    }
    
    
    
    @IBAction func SearchItem(_ sender: Any) {
        print("searching for item \(String(describing: itemSearchTextField.text))")
        
        guard let str = itemSearchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        if str.count >= 2 {
            search(s: str)
        }
        
        self.rawItems.removeAll()
        self.itemsTableView.reloadData()
    }
    
    func search(s: String){
        guard let url = URL(string: "https://walmart2.p.rapidapi.com/search?query=\(s)") else {
            return
        }
        
        let headers = [
            "x-rapidapi-key": "478c5bbd95mshe675fbe01298f00p1f0beajsndf857b06d8f6"
        ]
        
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dataDictionary = jsonObject as? [String: Any],
                       let resultItems = dataDictionary["items"] as? [[String : Any]]
                    {
                        DispatchQueue.main.async {
                            self.rawItems = resultItems
                            self.itemsTableView.reloadData()
                        }
                    } else {
                        print("Corrupted data")
                    }
                } catch (let error) {
                    print(error)
                }
            } else {
                if let error = error {
                    print(error)
                } else {
                    // Imposible case
                }
            }
        })

        dataTask.resume()
    }
}



extension UIViewController: ItemCellDelegate{
    func AddItem(with cell: ItemCell) {
        let defaults = UserDefaults.standard
        let ListID = defaults.string(forKey: "currentListID") ?? ""
        if (!cell.isAdded){
            print("ItemName: \(cell.ItemName.text)")
            print("DescriptionLabble: \(cell.DescriptionLabble.text)")
        
            let post = PFObject(className: "ItemsTable")
            post["ListID"] = ListID
            post["ItemName"] = cell.ItemName.text
            post["Description"] = cell.DescriptionLabble.text
            let imageData = cell.ImageOfItem.image!.pngData()
            let file = PFFileObject(name:"image.png", data: imageData!)
        
            post["image"] = file
        
            post.saveInBackground{ (success, error) in
                if (success){
                    //self.dismiss(animated: true, completion: nil)
                    print("saved!")
                }else{
                    print("error!")
                }
            
            }
            //cell.ItemCellAddbuttom.titleLabel?.textColor = UIColor.gray
            cell.ItemCellAddbuttom.setTitle("Remove", for: .normal)
            cell.ItemCellAddbuttom.setTitleColor(UIColor.gray, for: .normal)
            cell.isAdded = true
        }else{
            print("delete ItemName: \(cell.ItemName.text)")
//            let post = PFObject(className: "ItemsTable")
//            post["ListID"] = ListID
//            post["ItemName"] = cell.ItemName.text
//            post.deleteInBackground()

            let query = PFQuery(className: "ItemsTable")
            // the key "requestResponded" is not True
            query.whereKey("ListID", equalTo: ListID)
            // for deleting the object is that it belongs to the current user
            query.whereKey("ItemName", equalTo: cell.ItemName.text)
            query.findObjectsInBackground(block: { (objects, error) -> Void in
                if error != nil{
                    print(error)
                }
                //  objects are those the key "requestResponded" is not True and belongs to the current user
                objects?.forEach({ object in
                    object.deleteInBackground()
                })
                // other case
                if objects?.count == 0 { // no match result found
                }
            })
            cell.ItemCellAddbuttom.setTitle("Add", for: .normal)
            cell.ItemCellAddbuttom.setTitleColor(UIColor.blue, for: .normal)
            cell.isAdded = false
        }
        
    }
    
    
}
