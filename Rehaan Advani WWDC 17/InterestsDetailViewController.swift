//
//  InterestsDetailViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 12/27/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class InterestsDetailViewController: UIViewController {

    var titleText = String()
    var imageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    var desc = UILabel()
    var caption = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addImage()
        self.insertGradient()
        self.addDescription()
        
        if self.title == "Basketball" {
            self.basketball()
        } else if self.title == "Tennis" {
            self.tennis()
        } else if self.title == "Food" {
            self.food()
        } else {
            self.computerScience()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            NotificationCenter.default.addObserver(AboutMeViewController(), selector: #selector(AboutMeViewController().navBar), name: NSNotification.Name(rawValue: "navBar"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "navBar"), object: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBar()
    }
    
    func navBar() {
        self.title = self.titleText
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    func basketball() {
        self.imageView.image = UIImage(named: "game")
        self.desc.text = "I am a HUGE Golden State Warriors fan 🏀! I regularly attend games at Oracle Arena, and I love to watch basketball during my free time. My favorite player on the Warriors would have to be Steph Curry. He is extremely effortless on the court, and an amazing shooter as well! The picture above was taken of my father, my brother, and I during a Warriors game against the Toronto Raptors."
        self.caption = "This picture was taken during a Warriors game with my brother and my father."
    }
    
    func computerScience() {
        self.imageView.image = UIImage(named: "codeIntern")
        self.desc.text = "Computer science is my passion. I love to build and create products that can change the world and impact others in a positive way. Computer science and coding is an extremely valuable skill to have, especially how the world is changing. I love to code on a daily basis, whether it is on personal projects, or for my AP Computer Science class."
        self.caption = "This picture was taken by the CEO of hiQ Labs during my internship over the summer of 2016."
    }
    
    func tennis() {
        self.imageView.image = UIImage(named: "tennisTeam")
        self.desc.text = "I am an extremely avid tennis player, who is on the high school tennis team. Not only do I like playing the sport recreationally, I also like playing it competitively. This is why a team atmosphere is a great fit for me. In addition to playing tennis, I also love watching it. My favorite player is Rafael Nadal, despite his injuries and his level of playing decreasing."
        self.caption = "This is a picture of me and the rest of the paly tennis team right before a match."
    }
    
    func food() {
        self.imageView.image = UIImage(named: "innout")
        self.desc.text = "I would consider myself to be extremely fond of food. Not only is food great to conusme, it is also great to bond with others and is a great way to socialize and connect. My favorite food item is a burger, specifically an In & Out burger as illustrated by the picture above. In addition, I love to eat food from lots of different cuisines, such as Indian, Italian, Thai, Japanese, Chinese, etc."
        self.caption = "This picture shows an In & Out joint in the bay area, specifically Mountain View, CA."
    }
    
    func addImage() {
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.view.addSubview(self.imageView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.4, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)) //-64
        
        self.insertGradient()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))
    }
    
    func imageTapped() {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(self.imageView.image!)
        photo.caption = self.caption
        images.append(photo)
        
        let browser = SKPhotoBrowser(originImage: self.imageView.image!, photos: images, animatedFromView: self.imageView)
        browser.initializePageIndex(0)
        SKPhotoBrowserOptions.captionFont = UIFont(name: "SFUIText-Regular", size: 18)!
        SKPhotoBrowserOptions.textAndIconColor = UIColor.white
        SKPhotoBrowserOptions.bounceAnimation = true
        self.present(browser, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.gradientLayer.frame = self.imageView.bounds
        self.gradientLayer.masksToBounds = true
    }
    
    func insertGradient() {
        self.gradientLayer.frame = self.imageView.bounds
        self.gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
        self.gradientLayer.locations = [0.5, 1.0]
        self.imageView.layer.insertSublayer(self.gradientLayer, at: 1)
    }
    
    func addDescription() {
        self.desc.font = UIFont(name: "SFUIText-Regular", size: 18)
        self.desc.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.desc.textAlignment = .left
        self.desc.sizeToFit()
        self.desc.numberOfLines = 0
        self.view.addSubview(self.desc)
        
        self.desc.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.desc, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.desc, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.desc, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1.0, constant: 30))
    }
}
