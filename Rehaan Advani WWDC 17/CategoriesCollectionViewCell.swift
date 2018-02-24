//
//  CategoriesCollectionViewCell.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/24/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    var title = UILabel()
    
    func drawImageView() {
        self.imageView.contentMode = .scaleAspectFill
        self.contentView.addSubview(self.imageView)
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .width, relatedBy: .equal, toItem: self.contentView, attribute: .width, multiplier: 0.8, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.8, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0))
    }
    
    func drawTitle() {
        self.title.font = UIFont(name: "SFUIText-Regular", size: 20)
        self.title.textAlignment = .center
        self.title.textColor = UIColor.white
        self.title.numberOfLines = 0
        self.contentView.addSubview(self.title)
        
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addConstraint(NSLayoutConstraint(item: self.title, attribute: .width, relatedBy: .equal, toItem: self.imageView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.title, attribute: .height, relatedBy: .equal, toItem: self.imageView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.title, attribute: .centerX, relatedBy: .equal, toItem: self.imageView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.contentView.addConstraint(NSLayoutConstraint(item: self.title, attribute: .centerY, relatedBy: .equal, toItem: self.imageView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func draw() {
        self.drawImageView()
        self.drawTitle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.draw()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
