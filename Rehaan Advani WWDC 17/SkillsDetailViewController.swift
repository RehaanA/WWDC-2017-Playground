//
//  SkillsDetailViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/22/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit
import BAFluidView

class SkillsDetailViewController: UIViewController {
    var pageIndex = Int()
    var fluidView = BAFluidView()
    var nameLabel = UILabel()
    var percLabel = UILabel()
    let percs = [0.75, 0.7, 0.6, 0.7, 0.65, 0.5, 0.2]
    let names = ["Swift", "Java", "Objective-C", "HTML", "CSS", "Python", "JavaScript"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFluidView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addLabels()
        fluidView.fill(to: self.percs[self.pageIndex] as NSNumber)
        UIView.animate(withDuration: 0.25) {
            self.fluidView.alpha = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFluidView() {
        self.fluidView = BAFluidView(frame: self.view.frame, maxAmplitude: 50, minAmplitude: 5, amplitudeIncrement: 5)!
        self.fluidView.alpha = 0
        fluidView.fillColor = UIColor(hex: 0x08eac2)
        fluidView.fillAutoReverse = false
        fluidView.fillRepeatCount = 1
        fluidView.fillDuration = 5.0
        fluidView.startAnimation()
        self.view.addSubview(fluidView)
    }
    
    func addLabels() {
        self.nameLabel.text = self.names[self.pageIndex]
        self.nameLabel.font = UIFont(name: "SFUIText-Regular", size: 25)
        self.nameLabel.textColor = UIColor.black
        self.nameLabel.textAlignment = .center
        self.view.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.00000000001, constant: (CGFloat(1-self.percs[self.pageIndex]) * self.view.frame.size.height) - CGFloat(self.fluidView.maxAmplitude)))
        
        
        self.percLabel.text = String(Int(self.percs[self.pageIndex] * 100)) + "%"
        self.percLabel.font = UIFont(name: "SFUIText-Light", size: 20)
        self.percLabel.textColor = UIColor.black
        self.percLabel.textAlignment = .center
        self.view.addSubview(self.percLabel)
        
        self.percLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.percLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.5, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.percLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.percLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    }

}
