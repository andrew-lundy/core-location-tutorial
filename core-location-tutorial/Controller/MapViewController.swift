//
//  MapViewController.swift
//  core-location-tutorial
//
//  Created by Andrew Lundy on 10/11/20.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {

    // MARK: - Properties
    var mapView: MKMapView!
    var userLocation: CLLocation!
    
    // MARK: - Methods

    func setupView() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        mapView.delegate = self
        mapView.region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.tintColor = UIColor(red: 0.72, green: 0.25, blue: 0.05, alpha: 1)
        view.addSubview(mapView)
        
        applyAutoConstraints()
    }
    
    func applyAutoConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func dismissToMainView() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View Your Location"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissToMainView))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 0.72, green: 0.25, blue: 0.05, alpha: 1)
        
        setupView()
     
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        mapView.setRegion(MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
    }
}
