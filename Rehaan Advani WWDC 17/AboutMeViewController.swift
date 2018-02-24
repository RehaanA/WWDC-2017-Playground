//
//  AboutMeViewController.swift
//  
//
//  Created by Rehaan Advani on 11/26/16.
//
//

import UIKit
import KMSegmentedControl
import MapKit
import SafariServices
import SimpleAnimation

class AboutMeViewController: UIViewController, KMSegmentedControlDelegate, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    var segmentedControl = KMSegmentedControl()
    
    //Interests
    var interestsTableView = UITableView()
    var interestsCategories = ["Computer Science", "Tennis", "Basketball", "Food"]
    var interestsImages = [UIImage(named: "cs"), UIImage(named: "tennis"), UIImage(named: "goldenstate"), UIImage(named: "cookie")]
    
    //About Me
    var profilePicture = UIImageView()
    var nameLabel = UILabel()
    var titleLabel = UILabel()
    var ageLabel = UILabel()
    var mapView = MKMapView()
    var linkedinImageView = UIImageView()
    var twitterImageView = UIImageView()
    var fbImageView = UIImageView()
    
    //Education
    //255, 216, 33
    var colors = [UIColor(red: 230/255, green: 184/255, blue: 0/255, alpha: 1.0), UIColor(red: 27/255, green: 46/255, blue: 88/255, alpha: 1.0), UIColor(red: 1/255, green: 129/255, blue: 63/255, alpha: 1.0), UIColor(red: 0/255, green: 51/255, blue: 0/255, alpha: 1.0), UIColor(red: 154/255, green: 0/255, blue: 0/255, alpha: 1.0)]
    var logos = [UIImage(named: "DSB"), UIImage(named: "SAS"), UIImage(named: "Jordan"), UIImage(named: "Paly"), UIImage(named: "Stanford")]
    var names = ["German School of Bombay", "Singapore American School", "Jordan Middle School", "Palo Alto High School", "My Dream"]
    var descs = ["I attended the German School while I lived in Mumbai, India in the 4th grade. During this year, I made many friends whom I am still connected with to this day.", "I attended the American School in Singapore for seven years, from grades 2 until 7. Living in a different continent for an extended period of time allowed me to appreciate other cultures and experiences.", "I attended Jordan Middle School in Palo Alto, CA for my 8th grade academic year. During this year, I was awarded the Jordan Award, which recognizes students for excellent academic achievement and impact on the community.", "I am currently attended the Palo Alto High School located in Palo Alto, CA. I expect to graduate in June 2019. Some of the courses I am currently taking include AP Computer Science, Honors Trigonometry, Honors Chemistry, etc.", "My dream is to attend Stanford University. Not only does it have an extremely prestigious computer science program, it is well connected with Silicon Valley."]
    var schoolTableView = UITableView()
    var blurEffectView = UIVisualEffectView()
    let imageView = UIImageView()
    var infoView = UIView()
    var schoolNameLabel = UILabel()
    var schoolDescLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addSegmentedControl()
        self.registerForce()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.navBar), name: NSNotification.Name(rawValue: "navBar"), object: nil)
        
        self.displayInfoUIElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func navBar() {
        self.title = "About Me"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30/255, green: 139/255, blue: 195/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 30/255, green: 139/255, blue: 195/255, alpha: 1.0)
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close(sender:)))
        self.navigationItem.leftBarButtonItem = close
    
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let app = UIApplication.shared
        let statusBarHeight = app.statusBarFrame.size.height
        let statusBarView = UIView(frame: CGRect(x: 0, y: -1 * statusBarHeight, width: self.view.frame.size.width, height: statusBarHeight))
        statusBarView.backgroundColor = UIColor(red: 30/255, green: 139/255, blue: 195/255, alpha: 1.0)
    }
    
    func close(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSegmentedControl() {
        self.segmentedControl.KMBackgroundColor = UIColor.white
        self.segmentedControl.KMSelectedItemColor = UIColor.white
        self.segmentedControl.KMSelectedTitleColor = UIColor(red: 30/255, green: 139/255, blue: 195/255, alpha: 1.0)
        self.segmentedControl.KMUnSelectedTitleColor = UIColor.black
        self.segmentedControl.KMSelectorLineColor = UIColor(red: 30/255, green: 139/255, blue: 195/255, alpha: 1.0)
        self.segmentedControl.KMFontSize = 15
        self.segmentedControl.items = ["Information", "Education", "Interests"]
        self.segmentedControl.KMShowSeperatorLines = false
        self.segmentedControl.UIElements = [.SelectorLine]
        self.segmentedControl.KMBorderWidth = 0.5
        self.segmentedControl.KMBorderColor = UIColor.lightGray
        self.segmentedControl.isUserInteractionEnabled = true
        self.segmentedControl.delegate = self
        self.view.addSubview(self.segmentedControl)
        
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.segmentedControl, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 1.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.segmentedControl, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 44.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.segmentedControl, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.segmentedControl, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: -1))
    }
    
    func KMSegmentedControlItemSelected(item: UIButton) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        if item.tag == 0 {
            self.clearScreen()
            self.displayInfoUIElements()
        } else if item.tag == 1 {
            self.clearScreen()
            self.displayEducationUIElements()
        } else {
            self.clearScreen()
            self.displayInterestsUIElements()
        }
    }
    
    
    //MARK: Information
    func displayInfoUIElements() {
        //Name, age, location
        self.addProfilePicture()
        self.addName()
        self.addTitle()
        self.addAge()
        self.addMapView()
        self.addSocial()
    }
    
    func addProfilePicture() {
        self.profilePicture.image = #imageLiteral(resourceName: "profilePic")
        self.profilePicture.layer.borderWidth = 7
        self.profilePicture.layer.borderColor = UIColor.lightGray.cgColor
        self.profilePicture.contentMode = .scaleAspectFill
        self.profilePicture.layer.cornerRadius = 60
        self.profilePicture.clipsToBounds = true
        self.view.addSubview(self.profilePicture)
        
        self.profilePicture.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.profilePicture, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 120))
        self.view.addConstraint(NSLayoutConstraint(item: self.profilePicture, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 120))
        self.view.addConstraint(NSLayoutConstraint(item: self.profilePicture, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: self.profilePicture, attribute: .top, relatedBy: .equal, toItem: self.segmentedControl, attribute: .bottom, multiplier: 1.0, constant: 25))
    }
    
    func addName() {
        self.nameLabel.text = "Rehaan Advani"
        self.nameLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 23)
        self.nameLabel.textAlignment = .left
        self.nameLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.view.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .left, relatedBy: .equal, toItem: self.profilePicture, attribute: .right, multiplier: 1.0, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .top, relatedBy: .equal, toItem: self.profilePicture, attribute: .top, multiplier: 1.0, constant: 10))
    }
    
    func addTitle() {
        self.titleLabel.text = "Software Engineer"
        self.titleLabel.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.titleLabel.textAlignment = .left
        self.titleLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.view.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.6, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .left, relatedBy: .equal, toItem: self.profilePicture, attribute: .right, multiplier: 1.0, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    }
    
    func addAge() {
        self.ageLabel.text = "16 years old"
        self.ageLabel.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.ageLabel.textAlignment = .left
        self.ageLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.view.addSubview(self.ageLabel)
        
        self.ageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.ageLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.ageLabel, attribute: .left, relatedBy: .equal, toItem: self.profilePicture, attribute: .right, multiplier: 1.0, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: self.ageLabel, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1.0, constant: 10))
    }
    
    func addMapView() {
        let annotation = MKPointAnnotation()
        annotation.title = "Palo Alto, CA"
        annotation.subtitle = "Place of Residence"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.443606, longitude: -122.131432)
        self.mapView.addAnnotation(annotation)
        self.view.addSubview(self.mapView)
        
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.4, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.mapView, attribute: .top, relatedBy: .equal, toItem: self.profilePicture, attribute: .bottom, multiplier: 1.0, constant: 20))
        
        self.mapView.selectAnnotation(annotation, animated: true)
        self.centerMapOnLocation(location: annotation.coordinate)
    }
    
    let regionRadius: CLLocationDistance = 10000
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addSocial() {
        self.linkedinImageView.image = #imageLiteral(resourceName: "linkedin")
        self.linkedinImageView.contentMode = .scaleToFill
        self.linkedinImageView.isUserInteractionEnabled = true
        self.view.addSubview(self.linkedinImageView)
        
        self.linkedinImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.linkedinImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.linkedinImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.linkedinImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.linkedinImageView, attribute: .top, relatedBy: .equal, toItem: self.mapView, attribute: .bottom, multiplier: 1.0, constant: 50))
        
        self.twitterImageView.image = #imageLiteral(resourceName: "twitter")
        self.twitterImageView.contentMode = .scaleToFill
        self.twitterImageView.isUserInteractionEnabled = true
        self.view.addSubview(self.twitterImageView)
        
        self.twitterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.twitterImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.twitterImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.twitterImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.twitterImageView, attribute: .top, relatedBy: .equal, toItem: self.mapView, attribute: .bottom, multiplier: 1.0, constant: 50))
        
        self.fbImageView.image = #imageLiteral(resourceName: "facebook")
        self.fbImageView.contentMode = .scaleToFill
        self.fbImageView.isUserInteractionEnabled = true
        self.view.addSubview(self.fbImageView)
        
        self.fbImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.fbImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.fbImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 50))
        self.view.addConstraint(NSLayoutConstraint(item: self.fbImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.fbImageView, attribute: .top, relatedBy: .equal, toItem: self.mapView, attribute: .bottom, multiplier: 1.0, constant: 50))
        
        self.fbImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.fbTapped(sender:))))
        self.linkedinImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.linkedinTapped(sender:))))
        self.twitterImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.twitterTapped(sender:))))
        
        self.linkedinImageView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
        self.twitterImageView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
        self.fbImageView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
    }
    
    func fbTapped(sender: UITapGestureRecognizer) {
        let url = URL(string: "https://www.facebook.com/rehaan.advani.9")!
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true, completion: nil)
    }
    
    func twitterTapped(sender: UITapGestureRecognizer) {
        let url = URL(string: "https://twitter.com/Rehaan_Advani")!
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true, completion: nil)
    }
    
    func linkedinTapped(sender: UITapGestureRecognizer) {
        let url = URL(string: "https://www.linkedin.com/in/rehaanadvani")!
        let vc = SFSafariViewController(url: url)
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: Education
    func displayEducationUIElements() {
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "educationBackground")!)
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: "educationBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.6
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: backgroundImageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        self.view.sendSubview(toBack: backgroundImageView)
        
        
        self.addEducationTableView()
        self.addBlurView()
        self.addInfoView()
    }
    
    func addEducationTableView() {
        self.schoolTableView.delegate = self
        self.schoolTableView.dataSource = self
        self.schoolTableView.register(EducationTableViewCell.self, forCellReuseIdentifier: "educationCell")
        self.schoolTableView.tableFooterView = UIView()
        self.schoolTableView.separatorStyle = .none
        self.schoolTableView.isScrollEnabled = false
        self.schoolTableView.backgroundView = nil
        self.schoolTableView.backgroundColor = UIColor.clear
        self.view.addSubview(self.schoolTableView)
        
        self.schoolTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.schoolTableView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.schoolTableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.85, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.schoolTableView, attribute: .top, relatedBy: .equal, toItem: self.segmentedControl, attribute: .bottom, multiplier: 1.0, constant: 25))
        self.view.addConstraint(NSLayoutConstraint(item: self.schoolTableView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
    
    func addBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView.frame = (UIApplication.shared).keyWindow!.bounds
        self.blurEffectView.alpha = 0
        (UIApplication.shared).keyWindow!.addSubview(blurEffectView)
    }
    
    
    func onTap(_ indexPath: NSIndexPath) {
        self.schoolTableView.isUserInteractionEnabled = false
        imageView.image = UIImage(named: "cancel")
        imageView.contentMode = .scaleToFill
        imageView.alpha = 0
        imageView.isUserInteractionEnabled = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.cancelTapped)))
        blurEffectView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: blurEffectView, attribute: .width, multiplier: 0, constant: 25))
        blurEffectView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: blurEffectView, attribute: .height, multiplier: 0, constant: 25))
        blurEffectView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: blurEffectView, attribute: .left, multiplier: 1.0, constant: 15))
        blurEffectView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: blurEffectView, attribute: .top, multiplier: 1.0, constant: 30))
        
        imageView.isUserInteractionEnabled = true
        
        UIView.animate(withDuration: 0.5) {
            self.blurEffectView.alpha = 1
            self.imageView.alpha = 1
            //self.infoView.alpha = 1
        }
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.25, options: .allowUserInteraction, animations: { 
            self.infoView.alpha = 1
        }, completion: nil)
        self.nameLabel.text = self.names[indexPath.row]
        self.schoolDescLabel.text = self.descs[indexPath.row]
        self.infoView.alpha = 1
        //self.infoView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
    }
    
    func cancelTapped() {
        self.blurEffectView.layoutIfNeeded()
        //self.infoView.popOut(toScale: 5, duration: 0.6, delay: 0, completion: nil)
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.3, options: .allowUserInteraction, animations: {
            self.imageView.alpha = 0
            self.infoView.alpha = 0
            self.imageView.isUserInteractionEnabled = false
            self.schoolTableView.isUserInteractionEnabled = true
            self.blurEffectView.alpha = 0
            self.blurEffectView.layoutIfNeeded()
        }, completion: nil)
    }
    
    func addInfoView() {
        self.infoView.backgroundColor = UIColor.white
        self.infoView.layer.cornerRadius = 10
        self.infoView.alpha = 0
        self.blurEffectView.addSubview(self.infoView)
        
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.infoView, attribute: .width, relatedBy: .equal, toItem: self.blurEffectView, attribute: .width, multiplier: 0.65, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.infoView, attribute: .height, relatedBy: .equal, toItem: self.blurEffectView, attribute: .height, multiplier: 0.4, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.infoView, attribute: .centerX, relatedBy: .equal, toItem: self.blurEffectView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.blurEffectView.addConstraint(NSLayoutConstraint(item: self.infoView, attribute: .centerY, relatedBy: .equal, toItem: self.blurEffectView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.nameLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.nameLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 20)
        self.nameLabel.textAlignment = .center
        self.nameLabel.numberOfLines = 0
        self.nameLabel.sizeToFit()
        self.infoView.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.infoView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.infoView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.infoView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.infoView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .top, relatedBy: .equal, toItem: self.infoView, attribute: .top, multiplier: 1.0, constant: 5))
        
        self.schoolDescLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.schoolDescLabel.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.schoolDescLabel.textAlignment = .center
        self.schoolDescLabel.numberOfLines = 0
        self.schoolDescLabel.sizeToFit()
        self.infoView.addSubview(self.schoolDescLabel)
        
        self.schoolDescLabel.translatesAutoresizingMaskIntoConstraints = false
        self.infoView.addConstraint(NSLayoutConstraint(item: self.schoolDescLabel, attribute: .width, relatedBy: .equal, toItem: self.infoView, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.infoView.addConstraint(NSLayoutConstraint(item: self.schoolDescLabel, attribute: .centerX, relatedBy: .equal, toItem: self.infoView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.infoView.addConstraint(NSLayoutConstraint(item: self.schoolDescLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
    }

    //MARK: Interests
    func displayInterestsUIElements() {
        self.interestsTableView.delegate = self
        self.interestsTableView.dataSource = self
        self.interestsTableView.register(InterestsTableViewCell.self, forCellReuseIdentifier: "cell")
        self.interestsTableView.tableFooterView = UIView()
        self.interestsTableView.isScrollEnabled = false
        self.view.addSubview(self.interestsTableView)
        
        self.interestsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.interestsTableView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.interestsTableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: -42))
        self.view.addConstraint(NSLayoutConstraint(item: self.interestsTableView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.interestsTableView, attribute: .top, relatedBy: .equal, toItem: self.segmentedControl, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.interestsTableView {
            let cell: InterestsTableViewCell! = self.interestsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! InterestsTableViewCell
            
            cell.categoryLabel.text = self.interestsCategories[indexPath.row]
            cell.backgroundImage.image = self.interestsImages[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            
            return cell
        } else {
            let educationCell: EducationTableViewCell! = self.schoolTableView.dequeueReusableCell(withIdentifier: "educationCell", for: indexPath) as! EducationTableViewCell
            educationCell.backView.backgroundColor = self.colors[indexPath.row]
            educationCell.logo.image = self.logos[indexPath.row]
            educationCell.name.text = self.names[indexPath.row]
           
            return educationCell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.interestsTableView {
            return self.interestsCategories.count
        } else {
            return self.names.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.interestsTableView {
            let detailView = InterestsDetailViewController()
            detailView.titleText = self.interestsCategories[indexPath.row]
            self.navigationController?.pushViewController(detailView, animated: true)
        } else {
            self.onTap(indexPath as NSIndexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.interestsTableView {
            return (self.view.frame.size.height - 42)/4
        } else {
            return 100
        }
    }
    
    func clearScreen() {
        for subview in self.view.subviews {
            if subview != self.segmentedControl {
                UIView.animate(withDuration: 3, animations: { 
                    subview.removeFromSuperview()
                })
            }
        }
        self.view.backgroundColor = UIColor.white
    }
}

extension AboutMeViewController {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = InterestsDetailViewController()
        let indexPath = self.interestsTableView.indexPathForRow(at: location)
        vc.titleText = self.interestsCategories[(indexPath?.row)!]
        previewingContext.sourceRect = (self.interestsTableView.cellForRow(at: indexPath!)?.frame)!
        return vc
    }
    
    @objc(previewingContext:commitViewController:)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }

    func registerForce() {
        if traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.interestsTableView)
        }
    }
}
