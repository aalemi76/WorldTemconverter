//
//  MapViewController.swift
//  WorldTempConverter
//
//  Created by Catalina on 3/22/20.
//  Copyright © 2020 Deep Minds. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    //MARK:- View declerations and Methods
    
    override func loadView() {
        //Create a map view:
        mapView = MKMapView()
        //Make this view as the default view of this UIView:
        view = mapView
        //Adding an Segmented Control Option:
        let standard = NSLocalizedString("Standard", comment: "Standard Map View")
        let hybrid = NSLocalizedString("Hybrid", comment: "Hybrid Map view")
        let satellite = NSLocalizedString("Satellite", comment: "Satellite Map View")
        let segmentedControl = UISegmentedControl(items: [standard, hybrid, satellite])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        let margins = view.layoutMarginsGuide
        
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    //MARK:- Functionality
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}
