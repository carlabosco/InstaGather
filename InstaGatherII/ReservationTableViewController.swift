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
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse) as? NSDictionary
//                print("json resonse: \(jsonResponse)") //Response result
                
                if let restaurants = jsonResponse?["restaurants"] as? [NSDictionary] {
                    self.restaurantArray = restaurants
                }
                
                print(self.restaurantArray)
//
                for restaurant in self.restaurantArray {
                    print(restaurant["name"])
                    var restAddress = restaurant["address"]
                    self.addressArray.append(restAddress)
//                    print(restaurant)
                }
                
                
//                let data = jsonResponse as! NSDictionary;
//
//                //value for key "bookings" will give you array
//                if let restaurants = data.value(forKey: "restaurants") as? NSArray {
//
////                    let restaurantObj = restaurants[0] as! NSDictionary;
////
////                    var address = restaurantObj.value(forKey: "address");
////                    var mobileReserve = restaurantObj.value(forKey: "mobile_reserve_url")
////                    print(mobileReserve)
////
////                    let arrayAddresses = restaurants.value(forKeyPath: "address") as! NSArray
////                    print(arrayAddresses)
//                }
               
                
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
        
        cell.textLabel?.text = self.addressArray[indexPath.row] as! String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addressArray.count

    }
    
}
