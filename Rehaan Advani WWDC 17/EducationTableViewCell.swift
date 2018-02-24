//
//  EducationTableViewCell.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/17/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {
    var backView = UIView()
    var logo = UIImageView()
    var name = UILabel()
    
    func drawBackground() {
        self.backView.layer.cornerRadius = 7
        self.contentView.addSubview(self.backView)
        
        self.backView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backView, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.9, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backView, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.75, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func drawLogo() {
        self.logo.contentMode = .scaleToFill
        self.backView.addSubview(self.logo)
        
        self.logo.translatesAutoresizingMaskIntoConstraints = false
        self.backView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .width, relatedBy: .equal, toItem: self.backView, attribute: .width, multiplier: 0, constant: 50))
        self.backView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .height, relatedBy: .equal, toItem: self.backView, attribute: .height, multiplier: 0, constant: 50))
        self.backView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .left, relatedBy: .equal, toItem: self.backView, attribute: .left, multiplier: 1.0, constant: 5))
        self.backView.addConstraint(NSLayoutConstraint(item: self.logo, attribute: .centerY, relatedBy: .equal, toItem: self.backView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func drawName() {
        self.name.textColor = UIColor.white
        self.name.textAlignment = .left
        self.name.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.backView.addSubview(self.name)
        
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.backView.addConstraint(NSLayoutConstraint(item: self.name, attribute: .width, relatedBy: .equal, toItem: self.backView, attribute: .width, multiplier: 0.75, constant: 0))
        self.backView.addConstraint(NSLayoutConstraint(item: self.name, attribute: .left, relatedBy: .equal, toItem: self.logo, attribute: .right, multiplier: 1.0, constant: 10))
        self.backView.addConstraint(NSLayoutConstraint(item: self.name, attribute: .centerY, relatedBy: .equal, toItem: self.backView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
    }

    func draw() {
        self.drawBackground()
        self.drawLogo()
        self.drawName()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: true)
    }
}
