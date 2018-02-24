//
//  ProjectsDetailPageViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/25/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit

class ProjectsDetailPageViewController: UIViewController {
    var pageIndex = Int()
    let screenshot = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.clear
        self.addScreenshot()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addScreenshot() {
        self.screenshot.contentMode = .scaleAspectFit
        self.screenshot.isUserInteractionEnabled = true
        self.view.addSubview(self.screenshot)
        
        self.screenshot.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.screenshot, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.screenshot, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.screenshot, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.screenshot, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
        
    }
   
}
