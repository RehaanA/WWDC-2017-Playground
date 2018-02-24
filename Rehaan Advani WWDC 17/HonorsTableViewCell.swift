//
//  HonorsTableViewCell.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 3/4/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit

class HonorsTableViewCell: UITableViewCell {
    let background = UIImageView()
    let nameLabel = UILabel()
    let companyLabel = UILabel()
    
    func drawLabels() {
        self.nameLabel.font = UIFont(name: "SFUIText-Regular", size: 25)
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.textAlignment = .center
        self.contentView.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: -10))
        
        
        self.companyLabel.font = UIFont(name: "SFUIText-Light", size: 20)
        self.companyLabel.textColor = UIColor.white
        self.companyLabel.textAlignment = .center
        self.contentView.addSubview(self.companyLabel)
        
        self.companyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.companyLabel, attribute: .top, relatedBy: .equal, toItem: self.nameLabel, attribute: .bottom, multiplier: 1.0, constant: 5))
    }
    
    func drawBackground() {
        self.background.contentMode = .scaleToFill
        self.backgroundView = self.background
    }
    
    func draw() {
        self.drawBackground()
        self.drawLabels()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
