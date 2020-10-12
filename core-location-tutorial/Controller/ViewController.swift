//
//  ViewController.swift
//  core-location-tutorial
//
//  Created by Andrew Lundy on 8/15/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var obtainLocationButton: UIButton!
    @IBOutlet weak var reverseGeocodeLocationButton: UIButton!
    @IBOutlet weak var viewLocationOnMapButton: UIButton!
    @IBOutlet weak var locationDataLbl: UILabel!
    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation!
    private var geocoder: CLGeocoder!
    
   
    // MARK: - Methods
    @IBAction func obtainLocationButtonPressed(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            // Request when in use authorization status.
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func reverseGeocodeLocationBttnTapped(_ sender: Any) {
        guard let currentLocation = self.currentLocation else {
            print("Unable to reverse-geocode location.")
            return
        }
        
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
         
            if let error = error {
                print(error)
            }
            
            
            guard let placemark = placemarks?.first else { return }
         
        
            guard let streetNumber = placemark.subThoroughfare else { return }
            guard let streetName = placemark.thoroughfare else { return }
            guard let city = placemark.locality else { return }
            guard let state = placemark.administrativeArea else { return }
            guard let zipCode = placemark.postalCode else { return }
            
       
            DispatchQueue.main.async {
                self.locationDataLbl.text = "\(streetNumber) \(streetName) \n \(city), \(state) \(zipCode)"
            }
        }
    }
    
    @IBAction func viewLocationOnMapButtonPressed(_ sender: Any) {
        // 1
        let mapViewController = MapViewController()
        // 2
        mapViewController.userLocation = currentLocation
        // 3
        let navigationController = UINavigationController(rootViewController: mapViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        obtainLocationButton.layer.cornerRadius = 10
        reverseGeocodeLocationButton.layer.cornerRadius = 10
        reverseGeocodeLocationButton.titleLabel?.textAlignment = .center
        
        viewLocationOnMapButton.layer.cornerRadius = 10
        viewLocationOnMapButton.titleLabel?.textAlignment = .center
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // Initialize the Geocoder
        geocoder = CLGeocoder()
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
        default:
            return
        }
    }
}






