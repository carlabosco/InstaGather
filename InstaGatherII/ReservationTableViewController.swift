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
    var tableArray = [String] ()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        print(event!.address!)
        
        parseJSON()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
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
                    dataResponse, options: [])
                print(jsonResponse) //Response result
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
        
        }
    }

