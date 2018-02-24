//
//  ProjectsTableViewCell.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/19/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    var icon = UIImageView()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    var descLabel = UILabel()

    func drawIcon() {
        self.icon.contentMode = .scaleAspectFill
        self.icon.layer.cornerRadius = 15
        self.icon.clipsToBounds = true
        self.icon.layer.borderWidth = 0.5
        self.icon.layer.borderColor = UIColor.black.cgColor
        self.contentView.addSubview(self.icon)
        
        self.icon.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.icon, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0, constant: 75))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.icon, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0, constant: 75))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.icon, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1.0, constant: 20))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.icon, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func drawName() {
        self.nameLabel.font = UIFont(name: "SFUIDisplay-Bold", size: 20)
        self.nameLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.nameLabel.textAlignment = .left
        self.contentView.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.75, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .left, relatedBy: .equal, toItem: self.icon, attribute: .right, multiplier: 1.0, constant: 10))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .top, relatedBy: .equal, toItem: self.icon, attribute: .top, multiplier: 1.0, constant: 0))
    }
    
    func drawDate() {
        self.dateLabel.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.dateLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.dateLabel.textAlignment = .left
        self.contentView.addSubview(self.dateLabel)
        
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dateLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.75, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dateLabel, attribute: .left, relatedBy: .equal, toItem: self.nameLabel, attribute: .left, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.dateLabel, attribute: .centerY, relatedBy: .equal, toItem: self.icon, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func drawDesc() {
        self.descLabel.font = UIFont(name: "SFUIText-Light", size: 15)
        self.descLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.descLabel.textAlignment = .left
        self.descLabel.sizeToFit()
        self.descLabel.numberOfLines = 0
        self.descLabel.lineBreakMode = .byTruncatingTail
        self.contentView.addSubview(self.descLabel)
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.75, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .left, relatedBy: .equal, toItem: self.dateLabel, attribute: .left, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .top, relatedBy: .equal, toItem: self.dateLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .bottom, relatedBy: .equal, toItem: self.icon, attribute: .bottom, multiplier: 1.0, constant: 0.0))
    }
    
    func draw() {
        self.drawIcon()
        self.drawName()
        self.drawDate()
        self.drawDesc()
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
