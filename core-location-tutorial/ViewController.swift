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
    @IBOutlet weak var reverseGeocodeLocation: UIButton!
    @IBOutlet weak var locationDataLbl: UILabel!
    
    private var locationManager: CLLocationManager!
    private var geocoder: CLGeocoder!
    private var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLocationBttn.layer.cornerRadius = 10
        reverseGeocodeLocation.layer.cornerRadius = 10
        reverseGeocodeLocation.titleLabel?.textAlignment = .center
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
    }
    
    @IBAction func changeLocationBttnTapped(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            // Request when in use authorization status.
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func reverseGeocodeLocationBttnTapped(_ sender: Any) {
        guard let locationText = locationDataLbl.text else { return }
        guard let currentLocation = locationManager.location else { return }
        
        let location = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude) 
        
        
        if locationText == "Location Data" {
            print("Unable to reverse-geocode location.")
        } else {
            geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { ([CLPlacemark], error) in
                <#code#>
            }
            print(location)
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
            self.currentLocation = currentLocation
            locationDataLbl.text = "\(currentLocation.coordinate)"
            print("LOCATION: \(currentLocation.timestamp)")
        default:
            return
        }
    }
}





