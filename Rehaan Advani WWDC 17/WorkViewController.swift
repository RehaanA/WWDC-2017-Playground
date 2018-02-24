//
//  WorkViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/26/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit
import SafariServices

class WorkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let headerImage = UIImageView()
    let logoImage = UIImageView()
    let nameLabel = UILabel()
    let placeLabel = UILabel()
    let scrollView = UIScrollView()
    let locationIcon = UIImageView()
    let websiteIcon = UIImageView()
    
    let headers = ["Dates", "Title", "Company Description", "What I Did", "What I Learned"]
    let descs = ["June 2016 - October 2016", "Software Engineering Intern", "hiQ Labs is the Global Standard for People Analytics. hiQ Labs is fundamentally changing the enterprise workforce by using predictive analytics to make sophisticated employee decisions. hiQ Labs’ elite data teams apply data-driven science to the evolution and development of your workforce and individual employees work lives.", "While working on hiQ's engineering team, I developed a mobile app for their Data Science/HR Conference, Elevate. This mobile app is an interactive itinerary for conference attendees that allows them to access relevant information, such as the agenda, speakers, etc. In addition, it also allows attendees to get directions, live tweet, and even share their profile. View the projects page to learn more about this. ", "One of the most important things I learned while interning was how to work and collaborate on a team. This is an extremely important life skill to have."]
    let tableView = UITableView()
    var heightConstraint = NSLayoutConstraint()
    var scrollViewHeightConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addScrollView()
        self.addHeader()
        self.addTableView()
    }
    
    func setUserInteraction() {
        self.headerImage.isUserInteractionEnabled = true
        for subview in self.headerImage.subviews {
            subview.isUserInteractionEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navBar() {
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close(sender:)))
        self.navigationItem.leftBarButtonItem = close
        
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    func close(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addScrollView() {
        self.scrollView.isScrollEnabled = true
        self.view.addSubview(self.scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        
        self.scrollViewHeightConstraint = NSLayoutConstraint(item: self.scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 64)
        self.view.addConstraint(self.scrollViewHeightConstraint)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: -64))
    }
    
    func addHeader() {
        self.addImageHeader()
        self.addLogoImage()
        self.addNameLabel()
        self.addPlaceLabel()
        self.addLocationIcon()
        self.addWebsiteIcon()
        self.setUserInteraction()
    }
    
    func addImageHeader() {
        self.headerImage.image = UIImage(named: "back-1")!.alpha(0.85)  //sfBackNight
        self.headerImage.contentMode = .scaleAspectFill
        self.headerImage.backgroundColor = UIColor(white: 1, alpha: 0.75)
        self.scrollView.addSubview(self.headerImage)
        
        self.headerImage.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.headerImage, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.headerImage, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0.8, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.headerImage, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.headerImage, attribute: .top, relatedBy: .equal, toItem: self.scrollView, attribute: .top, multiplier: 1.0, constant: 0.0))
        //self.scrollView.addConstraint(NSLayoutConstraint(item: self.headerImage, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    func addLogoImage() {
        self.logoImage.backgroundColor = UIColor.white.withAlphaComponent(0.65)
        self.logoImage.clipsToBounds = true
        self.logoImage.contentMode = .scaleAspectFill
        self.logoImage.layer.cornerRadius = 60
        self.headerImage.addSubview(self.logoImage)
        
        self.logoImage.translatesAutoresizingMaskIntoConstraints = false
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.logoImage, attribute: .width, relatedBy: .equal, toItem: self.headerImage, attribute: .width, multiplier: 0, constant: 120))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.logoImage, attribute: .height, relatedBy: .equal, toItem: self.headerImage, attribute: .height, multiplier: 0, constant: 120))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.logoImage, attribute: .centerX, relatedBy: .equal, toItem: self.headerImage, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.logoImage, attribute: .top, relatedBy: .equal, toItem: self.headerImage, attribute: .top, multiplier: 1.0, constant: 30))
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "hiq"))
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerRadius = 60
        self.logoImage.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logoImage.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .width, relatedBy: .equal, toItem: self.logoImage, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.logoImage.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .height, relatedBy: .equal, toItem: self.logoImage, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.logoImage.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .centerX, relatedBy: .equal, toItem: self.logoImage, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.logoImage.addConstraint(NSLayoutConstraint(item: logoImageView, attribute: .centerY, relatedBy: .equal, toItem: self.logoImage, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
    }
    
    func addNameLabel() {
        self.nameLabel.text = "hiQ Labs"
        self.nameLabel.font = UIFont(name: "SFUIText-Regular", size: 25)
        self.nameLabel.textColor = UIColor.white//UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.nameLabel.textAlignment = .center
        self.headerImage.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.headerImage, attribute: .width, multiplier: 0.75, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.headerImage, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .top, relatedBy: .equal, toItem: self.logoImage, attribute: .bottom, multiplier: 1.0, constant: 5))
    }
    
    func addPlaceLabel() {
        self.placeLabel.text = "San Francisco"
        self.placeLabel.font = UIFont(name: "SFUIText-Regular", size: 20)
        self.placeLabel.textColor = UIColor.white//UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.placeLabel.textAlignment = .center
        self.headerImage.addSubview(self.placeLabel)
        
        self.placeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.placeLabel, attribute: .width, relatedBy: .equal, toItem: self.headerImage, attribute: .width, multiplier: 0.75, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.placeLabel, attribute: .centerX, relatedBy: .equal, toItem: self.headerImage, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.placeLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    func addLocationIcon() {
        self.locationIcon.image = #imageLiteral(resourceName: "hiQLocationMarker")
        self.locationIcon.contentMode = .scaleAspectFill
        self.locationIcon.isUserInteractionEnabled = true
        self.headerImage.addSubview(self.locationIcon)
        
        self.locationIcon.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.locationIcon, attribute: .width, relatedBy: .equal, toItem: self.headerImage, attribute: .width, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.locationIcon, attribute: .height, relatedBy: .equal, toItem: self.headerImage, attribute: .height, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.locationIcon, attribute: .centerX, relatedBy: .equal, toItem: self.headerImage, attribute: .centerX, multiplier: 1.0, constant: -50))
        self.view.addConstraint(NSLayoutConstraint(item: self.locationIcon, attribute: .top, relatedBy: .equal, toItem: self.placeLabel, attribute: .bottom, multiplier: 1.0, constant: 15))
        
        self.locationIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.locationTapped)))
    }
    
    func addWebsiteIcon() {
        self.websiteIcon.image = #imageLiteral(resourceName: "browser")
        self.websiteIcon.contentMode = .scaleAspectFill
        self.websiteIcon.isUserInteractionEnabled = true
        self.headerImage.addSubview(self.websiteIcon)
        
        self.websiteIcon.translatesAutoresizingMaskIntoConstraints = false
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.websiteIcon, attribute: .width, relatedBy: .equal, toItem: self.headerImage, attribute: .width, multiplier: 0, constant: 50))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.websiteIcon, attribute: .height, relatedBy: .equal, toItem: self.headerImage, attribute: .height, multiplier: 0, constant: 50))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.websiteIcon, attribute: .centerX, relatedBy: .equal, toItem: self.headerImage, attribute: .centerX, multiplier: 1.0, constant: 50))
        self.headerImage.addConstraint(NSLayoutConstraint(item: self.websiteIcon, attribute: .top, relatedBy: .equal, toItem: self.placeLabel, attribute: .bottom, multiplier: 1.0, constant: 15))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.websiteTapped))
        self.websiteIcon.addGestureRecognizer(tap)
    }
    
    func websiteTapped() {
        let url = URL(string: "https://www.hiqlabs.com")!
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true, completion: nil)
    }
    
    func locationTapped() {
        self.present(UINavigationController(rootViewController: WorkMapViewController()), animated: true, completion: nil)
    }
    
    func addTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(WorkTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.isScrollEnabled = false
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.tableFooterView = UIView()
        //self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = false
        self.scrollView.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 1.0, constant: 0.0))
        
        self.heightConstraint = NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 0)
        self.scrollView.addConstraint(self.heightConstraint)
        
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.headerImage, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WorkTableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkTableViewCell
        
        cell.header.text = self.headers[indexPath.row]
        cell.descLabel.text = self.descs[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headers.count
    }
    
    override func updateViewConstraints() {
       
        self.tableView.layoutIfNeeded()
        self.heightConstraint.constant = self.tableView.contentSize.height
        
        
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.tableView, attribute: .bottom, multiplier: 1.0, constant: 0.0))

        
        super.updateViewConstraints()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension UIImage {
    func alpha(_ value: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
