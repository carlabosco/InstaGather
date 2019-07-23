//
//  FormStep3ViewController.swift
//  InstaGatherII
//
//  Created by Carla Bosco on 07.07.19.
//  Copyright © 2019 Carla Bosco. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit

class FormStep3ViewController: UIViewController {
    
    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var event: Event?
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var locationName: String!
    var locationID: String!
//    var attributedString: NSMutableAttributedString?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        setupSearchController()
        
//        resultsViewController?.delegate = self
    }
    
    func setupSearchController() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        
        let searchBar = searchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Where are you meeting?"
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.event?.address = addressField.text
        self.event!.address = locationName
        self.event!.placeID = locationID
        let step4VC = segue.destination as! FormStep4ViewController
        print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY")
        print("https://www.google.com/maps/place/?q=place_id:\(event!.placeID!)")
        print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY")
        step4VC.event = self.event
    }
}

extension FormStep3ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        
        searchController?.isActive = false
        
        mapView.removeAnnotations(mapView.annotations)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: place.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        annotation.subtitle = place.formattedAddress
        mapView.addAnnotation(annotation)
        
        locationName = place.name!
        locationID = place.placeID!
        
        print(place.coordinate)
//        print(place.placeID!)
//        print(place.name!)
//        print("https://www.google.com/maps/place/?q=place_id:\(place.placeID!)")
        
        locationName = place.name ?? ""
//        attributedString = NSMutableAttributedString(string: locationName, attributes:[NSAttributedString.Key.link: URL(string: "https://www.google.com/maps/place/?q=place_id:\(placeID)")!])
//        
//        print(attributedString)
        
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
