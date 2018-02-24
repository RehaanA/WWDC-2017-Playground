//
//  WorkTableViewCell.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 3/3/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
    let header = UILabel()
    let descLabel = UILabel()
    
    func drawDesc() {
        self.descLabel.font = UIFont(name: "SFUIText-Regular", size: 17)
        self.descLabel.textAlignment = .left
        self.descLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.descLabel.numberOfLines = 0
        self.descLabel.sizeToFit()
        self.contentView.addSubview(self.descLabel)
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .top, relatedBy: .equal, toItem: self.header, attribute: .bottom, multiplier: 1.0, constant: 10))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -10))
    }
    
    func drawHeader() {
        self.header.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
        self.header.textAlignment = .left
        self.header.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.contentView.addSubview(self.header)
        
        self.header.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.header, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.9, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.header, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.header, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15))
    }
    
    func draw() {
        self.drawHeader()
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
