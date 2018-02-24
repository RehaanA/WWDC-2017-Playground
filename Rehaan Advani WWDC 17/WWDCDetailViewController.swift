//
//  WWDCDetailViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/18/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit
import SKPhotoBrowser

class WWDCDetailViewController: UIViewController {
    var pageIndex = Int()
    var imageView = UIImageView()
    var descLabel = UILabel()
    
    var topLeft = UIImageView()
    var topRight = UIImageView()
    var bottomLeft = UIImageView()
    var bottomRight = UIImageView()
    
    var background = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBackground()
        self.addImageView()
        self.addDescription()
    }
    
    func addBackground() {
        self.background.image = #imageLiteral(resourceName: "back2")
        self.background.contentMode = .scaleAspectFill
        self.background.clipsToBounds = true
        self.view.addSubview(self.background)
        
        self.background.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.background, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.background, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.background, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.background, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }

    func addImageView() {
        self.imageView.isUserInteractionEnabled = true
        if self.imageView.image != UIImage(named: "albumCover") {
            self.imageView.contentMode = .scaleAspectFill
            self.imageView.layer.cornerRadius = 15
            self.imageView.clipsToBounds = true
            self.view.addSubview(self.imageView)
            
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.4, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.65, constant: 0))
            
            self.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))

            //Top Left
            self.topLeft.image = UIImage(named: "topLeft")
            self.topLeft.contentMode = .scaleAspectFit
            self.view.addSubview(self.topLeft)
            
            self.topLeft.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.topLeft, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.topLeft, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.topLeft, attribute: .left, relatedBy: .equal, toItem: self.imageView, attribute: .left, multiplier: 1.0, constant: -20))
            self.view.addConstraint(NSLayoutConstraint(item: self.topLeft, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 70))
            
            //Top Right
            self.topRight.image = UIImage(named: "topRight")
            self.topRight.contentMode = .scaleAspectFit
            self.view.addSubview(self.topRight)
            
            self.topRight.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.topRight, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.topRight, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.topRight, attribute: .right, relatedBy: .equal, toItem: self.imageView, attribute: .right, multiplier: 1.0, constant: 20))
            self.view.addConstraint(NSLayoutConstraint(item: self.topRight, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 70))
            
            //Bottom Left
            self.bottomLeft.image = UIImage(named: "bottomLeft")
            self.bottomLeft.contentMode = .scaleAspectFit
            self.view.addSubview(self.bottomLeft)
            
            self.bottomLeft.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomLeft, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomLeft, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomLeft, attribute: .left, relatedBy: .equal, toItem: self.imageView, attribute: .left, multiplier: 1.0, constant: -20))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomLeft, attribute: .bottom, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1.0, constant: 20))
            
            //Bottom Right
            self.bottomRight.image = UIImage(named: "bottomRight")
            self.bottomRight.contentMode = .scaleAspectFit
            self.view.addSubview(self.bottomRight)
            
            self.bottomRight.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomRight, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomRight, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 70))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomRight, attribute: .right, relatedBy: .equal, toItem: self.imageView, attribute: .right, multiplier: 1.0, constant: 20))
            self.view.addConstraint(NSLayoutConstraint(item: self.bottomRight, attribute: .bottom, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1.0, constant: 20))
            
        } else {
            self.imageView.contentMode = .scaleToFill
            self.view.addSubview(self.imageView)
            
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
            self.view.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        }
        
    }
    
    func imageTapped() {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(self.imageView.image!)
        images.append(photo)
        
        let browser = SKPhotoBrowser(originImage: self.imageView.image!, photos: images, animatedFromView: self.imageView)
        browser.initializePageIndex(0)
        SKPhotoBrowserOptions.textAndIconColor = UIColor.white
        SKPhotoBrowserOptions.bounceAnimation = true
        self.present(browser, animated: true, completion: nil)
    }
    
    func addDescription() {
        //if self.imageView.image != UIImage(named: "albumCover") {
            self.descLabel.font = UIFont(name: "JOURNAL", size: 27)
            self.descLabel.textAlignment = .center
            self.descLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
            self.descLabel.numberOfLines = 0
            self.descLabel.sizeToFit()
            self.view.addSubview(self.descLabel)
            
            self.descLabel.translatesAutoresizingMaskIntoConstraints = false
            self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.9, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .top, relatedBy: .equal, toItem: self.imageView, attribute: .bottom, multiplier: 1.0, constant: 40))
        //}
    }
}
