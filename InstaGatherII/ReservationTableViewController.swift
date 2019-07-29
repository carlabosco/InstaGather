//
//  ReservationTableViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 7/25/19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit

class ReservationTableViewController: UITableViewController {
    
    var event: Event?
    var restaurantArray = [NSDictionary]()
    var addressArray = Array<Any>()
    var namesArray = Array<String>()
    var urlsArray = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(event!.address!)
        
        parseJSON()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    
    func parseJSON() {
        var task: URLSessionTask
        
        let txtAppend = (event!.address!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = "https://opentable.herokuapp.com/api/restaurants?name=\(txtAppend!)"
       
        task = URLSession.shared.dataTask(with: URL(string: "https://opentable.herokuapp.com/api/restaurants?name=\(txtAppend!)")!) { (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse) as? NSDictionary
                
                if let restaurants = jsonResponse?["restaurants"] as? [NSDictionary] {
                    self.restaurantArray = restaurants
                }
                
                print(self.restaurantArray)

                for restaurant in self.restaurantArray {
                    print(restaurant["name"] as Any)
                    let restAddress = restaurant["address"]
                    let restName = restaurant["name"]
                    let restURL = restaurant["mobile_reserve_url"]
                    let restImage = restaurant["img_url"]
                    self.addressArray.append(restAddress as Any)
                    self.namesArray.append(restName as! String)
                    self.urlsArray.append(restURL as! String)

                }
                
               
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
        
        }

    }

extension ReservationTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell

        cell.textLabel?.text = self.namesArray[indexPath.row]
        cell.detailTextLabel?.text = self.urlsArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        let urlString = self.urlsArray[indexPath.row]
        
        if let url = NSURL(string: urlString)
        {
            UIApplication.shared.openURL(url as URL)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressArray.count

    }
    
}
