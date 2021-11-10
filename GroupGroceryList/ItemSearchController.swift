//
//  ItemSearchController.swift
//  GroupGroceryList
//
//  Created by Ilya Zlatkin on 07.11.2021.
//

import UIKit

class ItemSearchController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var raw_items = [[String:Any]]()
    @IBOutlet weak var ItemSearchText: UITextField!
    
    
    @IBOutlet weak var AddItem: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AddItem.dataSource = self
        AddItem.delegate = self
        self.AddItem.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return raw_items.count
        //return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        var tmp_str = raw_items[indexPath.row]["title"] as! String
        var str = tmp_str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.ItemName.text = str
        tmp_str = raw_items[indexPath.row]["description"] as! String
        str = tmp_str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.DescriptionLabble.text = str
        let imageURL_string = raw_items[indexPath.row]["imageUrl"] as! String
        var imageURL = URL(string: imageURL_string )
        cell.ImageOfItem.af_setImage(withURL: imageURL!)
        return cell
    }
    
    @IBAction func SearchItem(_ sender: Any) {
        print("searching for item \(ItemSearchText.text)")
        let str = ItemSearchText.text
        if str?.count ?? 0 >= 2{

            search(s: str!.trimmingCharacters(in: .whitespacesAndNewlines))
            self.AddItem.reloadData()
            
        }
        else{
            //self.ItemsList.removeAll()
            self.raw_items.removeAll()
            self.AddItem.reloadData()
        }
    }
    
    func search(s: String){
            guard let url = URL(string: "https://walmart2.p.rapidapi.com/search?query=\(s)") else {
                return
            }
            
            let headers = [
                "x-rapidapi-key": "478c5bbd95mshe675fbe01298f00p1f0beajsndf857b06d8f6"
            ]
            
            let request = NSMutableURLRequest(
                url: url,
                cachePolicy: .useProtocolCachePolicy,
                timeoutInterval: 10.0
            )
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    if let data = data,
                       let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let resultItems = dataDictionary["items"] as? [[String : Any]]
                    {
                        self.raw_items = resultItems
                    }
                }
            })

            dataTask.resume()
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
