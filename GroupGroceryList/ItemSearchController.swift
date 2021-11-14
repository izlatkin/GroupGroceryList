//
//  ItemSearchController.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 07.11.2021.
//

import UIKit

class ItemSearchController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var rawItems = [[String:Any]]()
    
//    @IBOutlet weak var itemSearchTextField: UITextField!
//    @IBOutlet weak var itemsTableView: UITableView!
    
    @IBOutlet weak var itemSearchTextField: UITextField!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return cell
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
