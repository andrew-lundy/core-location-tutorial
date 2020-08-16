//
//  ViewController.swift
//  core-location-tutorial
//
//  Created by Andrew Lundy on 8/15/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var changeLocationBttn: UIButton!
    @IBOutlet weak var locationDataLbl: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLocationBttn.layer.cornerRadius = 10
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
    }
    
    @IBAction func changeLocationBttnTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            // Request when in use authorization status.
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Create a switch statement for the CLLocationManager.authorizationStatus() value
        switch CLLocationManager.authorizationStatus() {
        
        // Compare the switch value to the authorizedWhenInUse case
        case .authorizedWhenInUse:
            // Start reporting the user's location
            locationManager.startUpdatingLocation()
            guard let currentLocation = locationManager.location else { return }
            
            locationDataLbl.text = "\(currentLocation.coordinate)"
            print("LOCATION: \(currentLocation.timestamp)")
        default:
            return
        }
    }
}





