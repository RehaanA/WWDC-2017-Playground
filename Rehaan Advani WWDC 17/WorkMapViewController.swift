//
//  WorkMapViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 3/3/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit
import MapKit

class WorkMapViewController: UIViewController {

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addMapView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navBar() {
        self.title = "Location"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close))
        self.navigationItem.leftBarButtonItem = close
        
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addMapView() {
        let annotation = MKPointAnnotation()
        annotation.title = "San Francisco, CA"
        annotation.subtitle = "hiQ Headquarters"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.788585, longitude: -122.401273)
        self.mapView.addAnnotation(annotation)
        self.view.addSubview(self.mapView)
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.mapView.selectAnnotation(annotation, animated: true)
        self.centerMapOnLocation(location: annotation.coordinate)
    }
    
    let regionRadius: CLLocationDistance = 10000
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
}
