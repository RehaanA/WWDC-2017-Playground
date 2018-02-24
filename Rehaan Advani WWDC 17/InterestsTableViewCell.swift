//
//  InterestsTableViewCell.swift
//  
//
//  Created by Rehaan Advani on 12/27/16.
//
//

import UIKit

class InterestsTableViewCell: UITableViewCell {
    var categoryLabel = UILabel()
    var backgroundImage = UIImageView()
    
    func drawBackgroundImage() {
        self.backgroundImage.contentMode = .scaleToFill
        self.backgroundImage.isUserInteractionEnabled = true
        self.backgroundView = self.backgroundImage
        /*self.contentView.addSubview(self.backgroundImage)
        
        self.backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backgroundImage, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backgroundImage, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backgroundImage, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.backgroundImage, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))*/
    }
    
    func drawCategoryLabel() {
        self.categoryLabel.font = UIFont(name: "SFUIText-Regular", size: 25)
        self.categoryLabel.textColor = UIColor.white
        self.categoryLabel.textAlignment = .left
        self.contentView.addSubview(self.categoryLabel)
        
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.categoryLabel, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.75, constant: 0))
         self.contentView.addConstraint(NSLayoutConstraint(item: self.categoryLabel, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1.0, constant: 10))
         self.contentView.addConstraint(NSLayoutConstraint(item: self.categoryLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -10))
    }

    func draw() {
        self.drawBackgroundImage()
        self.drawCategoryLabel()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
