//
//  AchievementsViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/26/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit
import MapKit

class AchievementsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    let images = [UIImage(named: "wwdcBack"), UIImage(named: "twitterBack"), UIImage(named: "hiQHonorsBack")/*UIImage(named: "elevateBack")*/]
    let names = ["WWDC 2016 Scholarship", "Flight Scholarship", "hiQ Elevate"]
    let companies = ["Apple, Inc", "Twitter, Inc", "hiQ Labs, Inc"]
    let locations = ["WWDC 2016", "Twitter Flight 2015", "hiQ Elevate Location"]
    let subtitles = ["Moscone Center", "Bill Graham Civic Auditorium", "Intel Headquarters"]
    let coordinates = [[37.783867, -122.401238], [37.778012, -122.417277], [37.384751, -121.963951]]
    let details = ["I was one of the 350 selected scholars to attend WWDC 2016. I developed a winning application, had the chance to attend the conference, and briefly meet various apple executives such as Tim Cook, Craig Federighi, and John Geleynse.", "I was selected out of a large pool of applicants to attend Twitter's Flight Developer Conference where I had the chance to learn more about Fabric, as well as other developer technologies.", "I had the honor of attending hiQ Labs' Elevate conference three times at the age of 15 and 16. I learned more about how machine learning applied to the world of HR, and what hiQ is doing in this space."]
    
    let scrollView = UIScrollView()
    var blurEffectView = UIVisualEffectView()
    let cancelImageView = UIImageView()
    let logo = UIImageView()
    let nameLabel = UILabel()
    let companyLabel = UILabel()
    let mapView = MKMapView()
    let detailLabel = UILabel()
    
    let logos = [UIImage(named: "appleHonorsLogo"), UIImage(named: "twitterHonorsLogo"), UIImage(named: "hiqHonorsLogo")]
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addTableView()
        self.addBlurView()
        self.addScrollView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close(sender:)))
        self.navigationItem.leftBarButtonItem = close
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func close(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(HonorsTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.separatorStyle = .none
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 64))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: -64))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HonorsTableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HonorsTableViewCell
        
        cell.background.image = self.images[indexPath.row]!.alpha(0.75)
        cell.nameLabel.text = self.names[indexPath.row]
        cell.companyLabel.text = self.companies[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onTap(indexPath.row)
    }
    
    func addBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = (UIApplication.shared).keyWindow!.bounds
        self.blurEffectView.alpha = 0
        (UIApplication.shared).keyWindow!.addSubview(blurEffectView)
    }
    
    func onTap(_ indexPath: Int) {
        self.tableView.isUserInteractionEnabled = false
        self.scrollView.isUserInteractionEnabled = true
        self.cancelImageView.isUserInteractionEnabled = true
        
        for subview in self.scrollView.subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
        
        for annotation in self.mapView.annotations {
            self.mapView.removeAnnotation(annotation)
        }
        
        self.addLogo(indexPath)
        self.addNameLabel(indexPath)
        self.addCompanyLabel(indexPath)
        self.addMapView(indexPath)
        self.addDetailLabel(indexPath)
        
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.alpha = 1
            self.scrollView.alpha = 1
            self.cancelImageView.alpha = 1
        }
    }
    
    func addScrollView() {
        self.cancelImageView.isUserInteractionEnabled = false
        self.cancelImageView.alpha = 0
        self.cancelImageView.image = #imageLiteral(resourceName: "cancel-1")
        self.cancelImageView.contentMode = .scaleAspectFill
        self.blurEffectView.addSubview(self.cancelImageView)
        
        self.cancelImageView.translatesAutoresizingMaskIntoConstraints = false
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.cancelImageView, attribute: .width, relatedBy: .equal, toItem: self.blurEffectView, attribute: .width, multiplier: 0, constant: 40))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.cancelImageView, attribute: .height, relatedBy: .equal, toItem: self.blurEffectView, attribute: .height, multiplier: 0, constant: 40))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.cancelImageView, attribute: .centerX, relatedBy: .equal, toItem: self.blurEffectView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.cancelImageView, attribute: .bottom, relatedBy: .equal, toItem: self.blurEffectView, attribute: .bottom, multiplier: 1.0, constant: -20))
        
        self.scrollView.alpha = 0
        self.scrollView.isUserInteractionEnabled = false
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.layer.cornerRadius = 15
        self.scrollView.clipsToBounds = true
        self.blurEffectView.addSubview(self.scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .width, relatedBy: .equal, toItem: self.blurEffectView, attribute: .width, multiplier: 0.9, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .height, relatedBy: .equal, toItem: self.blurEffectView, attribute: .height, multiplier: 0.75, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.blurEffectView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.blurEffectView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.cancelImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cancelTapped)))
        
    }
    
    func cancelTapped() {
        self.tableView.isUserInteractionEnabled = true
        self.scrollView.isUserInteractionEnabled = false
        self.cancelImageView.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.5) { 
            self.blurEffectView.alpha = 0
            self.scrollView.alpha = 0
            self.cancelImageView.alpha = 0
        }
    }
    
    func addLogo(_ indexPath: Int) {
        var constant = 0
        self.logo.image = self.logos[indexPath]
        self.logo.contentMode = .scaleAspectFill
        self.scrollView.addSubview(self.logo)
        
        if self.logos[indexPath] == UIImage(named: "appleHonorsLogo") {
            constant = 50
        } else if self.logos[indexPath] == UIImage(named: "twitterHonorsLogo") {
            constant = 60
        } else {
            constant = 50
        }
        
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        
        self.widthConstraint = NSLayoutConstraint(item: self.logo, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: CGFloat(constant))
        self.scrollView.addConstraint(self.widthConstraint)
        
        self.heightConstraint = NSLayoutConstraint(item: self.logo, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: CGFloat(constant))
        self.scrollView.addConstraint(self.heightConstraint)
        
        
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 15))
    }
    
    func addNameLabel(_ indexPath: Int) {
        self.nameLabel.text = self.names[indexPath]
        self.nameLabel.font = UIFont(name: "SFUIText-Regular", size: 20)
        self.nameLabel.textAlignment = .center
        self.nameLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.scrollView.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .top, relatedBy: .equal, toItem: self.logo, attribute: .bottom, multiplier: 1.0, constant: 10))
    }
    
    func addCompanyLabel(_ indexPath: Int) {
        self.companyLabel.text = self.companies[indexPath]
        self.companyLabel.font = UIFont(name: "SFUIText-Light", size: 18)
        self.companyLabel.textAlignment = .center
        self.companyLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.scrollView.addSubview(self.companyLabel)
        
        self.companyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    func addMapView(_ indexPath: Int) {
        let annotation = MKPointAnnotation()
        annotation.title = self.locations[indexPath]
        annotation.subtitle = self.subtitles[indexPath]
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.coordinates[indexPath][0]), longitude: CLLocationDegrees(self.coordinates[indexPath][1]))
        self.mapView.addAnnotation(annotation)
        self.scrollView.addSubview(self.mapView)
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0.4, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .top, relatedBy: .equal, toItem: self.companyLabel, attribute: .bottom, multiplier: 1.0, constant: 15))
        
        self.mapView.selectAnnotation(annotation, animated: true)
        self.centerMapOnLocation(location: annotation.coordinate)
    }
    
    let regionRadius: CLLocationDistance = 10000
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addDetailLabel(_ indexPath: Int) {
        self.detailLabel.text = self.details[indexPath]
        self.detailLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.detailLabel.textAlignment = .center
        self.detailLabel.font = UIFont(name: "SFUIText-Light", size: 15)
        self.detailLabel.numberOfLines = 0
        self.detailLabel.sizeToFit()
        self.scrollView.addSubview(self.detailLabel)
        
        self.detailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.detailLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0.9, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.detailLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.detailLabel, attribute: .top, relatedBy: .equal, toItem: self.mapView, attribute: .bottom, multiplier: 1.0, constant: 20))
        
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.detailLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
}
