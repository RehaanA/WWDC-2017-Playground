//
//  ViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/23/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit
import SKPhotoBrowser
import JTMaterialTransition
import SimpleAnimation

class ViewController: UIViewController, UIScrollViewDelegate {
    var profileImageView = UIImageView()
    var backgroundImageView = UIImageView()
    var scrollView = UIScrollView()
    var arrowImageView = UIImageView()
    var nameLabel = UILabel()
    var titleLabel = UILabel()
    var tableView = UITableView()
    
    var aboutMeView = UIView()
    var projectsView = UIView()
    var skillsView = UIView()
    var workView = UIView()
    var achievementsView = UIView()
    var wwdc2016View = UIView()
    var counter = 0
    
    var aboutMeLabel = UILabel()
    var projectsLabel = UILabel()
    var skillsLabel = UILabel()
    var workLabel = UILabel()
    var achievementsLabel = UILabel()
    var wwdc2016Label = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackground()
        self.addScrollView()
        self.addImageViewWithAnimation()
        self.addTapGesture()
        self.addLabels()
        self.addArrow()
        self.addCategories()
        self.addTitleLabels()
        self.registerForce()
        self.registerNotifications()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = .black
    }
    
    func tap(sender: UITapGestureRecognizer) {
        print("called")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.aboutMeTapped), name: NSNotification.Name(rawValue: "aboutMe"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.projectsTapped), name: NSNotification.Name(rawValue: "projects"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.skillsTapped), name: NSNotification.Name(rawValue: "skills"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.wwdcTapped), name: NSNotification.Name(rawValue: "wwdc"), object: nil)
        
        (UIApplication.shared.delegate as! AppDelegate).triggerNotification()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addScrollView() {
        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height * 2)
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.isUserInteractionEnabled = true
        self.scrollView.delegate = self
        self.scrollView.isScrollEnabled = true
        self.view.addSubview(self.scrollView)
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            //Kill Scroll
            var offset = scrollView.contentOffset
            offset.x -= 1.0
            offset.y -= 1.0
            scrollView.setContentOffset(offset, animated: true)
            offset.x += 1.0
            offset.y += 1.0
            scrollView.setContentOffset(offset, animated: true)
            
            let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            if actualPosition.y > 0 {
                //Dragging Down
                scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
            } else {
                scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: self.view.frame.size.height), animated: true)
                self.animateViews()
                counter += 1
            }
        } else {
            if scrollView.contentOffset.y == self.view.frame.size.height {
                if scrollView.contentOffset.y < scrollView.contentSize.height / 4 {
                    scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: self.view.frame.size.height), animated: true)
                    self.animateViews()
                    counter += 1
                } else {
                    scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
                }
            } else {
                //Shows Pic
                if scrollView.contentOffset.y < scrollView.contentSize.height / 4 {
                    scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: 0), animated: true)
                } else {
                    scrollView.setContentOffset(CGPoint(x: scrollView.contentOffset.x, y: self.view.frame.size.height), animated: true)
                    self.animateViews()
                    counter += 1
                }
            }
        }
    }
   
    func addImageViewWithAnimation() {
        self.profileImageView.image = UIImage(named: "Rehaan")
        self.profileImageView.layer.borderWidth = 10
        self.profileImageView.layer.borderColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1.0).cgColor
        self.profileImageView.layer.cornerRadius = 75
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        self.profileImageView.isUserInteractionEnabled = true
        self.scrollView.addSubview(self.profileImageView)
        
        self.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.profileImageView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 150))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.profileImageView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 150))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.profileImageView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 0.9, constant: 0))
        
        self.profileImageView.popIn(fromScale: 5, duration: 0.6, delay: 0.3, completion: nil)
    }
    
    func addTapGesture() {
        self.profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTapped)))
    }
    
    func imageTapped() {
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(self.profileImageView.image!)
        photo.caption = "This image was taken during WWDC 2016, in front of Moscone Center in San Francisco."
        images.append(photo)
        
        let browser = SKPhotoBrowser(originImage: self.profileImageView.image!, photos: images, animatedFromView: self.profileImageView)
        browser.initializePageIndex(0)
        SKPhotoBrowserOptions.captionFont = UIFont(name: "SFUIText-Regular", size: 18)!
        SKPhotoBrowserOptions.textAndIconColor = UIColor.white
        SKPhotoBrowserOptions.bounceAnimation = true
        self.present(browser, animated: true, completion: nil)
    }
    
    func addLabels() {
        self.nameLabel.text = "Rehaan Advani"
        self.nameLabel.textColor = UIColor.white
        self.nameLabel.textAlignment = .center
        self.nameLabel.alpha = 0
        self.nameLabel.font = UIFont(name: "SFUIText-Regular", size: 22)
        self.scrollView.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0.75, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 1.2, constant: 0))
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: .allowUserInteraction, animations: { 
            self.nameLabel.alpha = 1
        }, completion: nil)
        
        self.titleLabel.text = "Student iOS Developer"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
        self.titleLabel.alpha = 0
        self.titleLabel.font = UIFont(name: "SFUIText-Light", size: 18)
        self.scrollView.addSubview(self.titleLabel)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .width, relatedBy: .equal, toItem: self.nameLabel, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self.nameLabel, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self.nameLabel, attribute: .centerY, multiplier: 1.075, constant: 0.0))
        
        UIView.animate(withDuration: 0.5, delay: 1.4, options: .allowUserInteraction, animations: {
            self.titleLabel.alpha = 1
        }, completion: nil)
    }
    
    func setBackground() {
        self.backgroundImageView.image = UIImage(named: "back6") //bkg
        self.backgroundImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.backgroundImageView)
        
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.backgroundImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.backgroundImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.backgroundImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.backgroundImageView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func addArrow() {
        self.arrowImageView.image = UIImage(named: "Arrow2")
        self.arrowImageView.contentMode = .scaleAspectFit
        self.scrollView.addSubview(self.arrowImageView)
        
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.arrowImageView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0.2, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.arrowImageView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0.1, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.arrowImageView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.arrowImageView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 1.9, constant: 0))
    }
    
    func addCategories() {
        //57.5, 115
        self.aboutMeView.layer.cornerRadius = 65
        self.aboutMeView.clipsToBounds = true
        self.aboutMeView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 0.55)
        self.aboutMeView.alpha = 0
        self.scrollView.addSubview(aboutMeView)
        
        self.aboutMeView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.aboutMeView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 130))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.aboutMeView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 130))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.aboutMeView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.075, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.aboutMeView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 3, constant: 0))
        
        self.aboutMeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aboutMeTapped)))
        
        
        self.projectsView.layer.cornerRadius = 62.5
        self.projectsView.clipsToBounds = true
        self.projectsView.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 0.75)
        self.projectsView.alpha = 0
        self.scrollView.addSubview(projectsView)
        
        self.projectsView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.projectsView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 125))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.projectsView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 125))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.projectsView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 0.45, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.projectsView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 3.3, constant: 0))
        
        self.projectsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(projectsTapped)))
        
        self.skillsView.layer.cornerRadius = 55
        self.skillsView.clipsToBounds = true
        self.skillsView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 0.55)
        self.skillsView.alpha = 0
        self.scrollView.addSubview(skillsView)
        
        self.skillsView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.skillsView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 110))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.skillsView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 110))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.skillsView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.55, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.skillsView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 2.6, constant: 0))
        
        self.skillsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(skillsTapped)))
        
        self.workView.layer.cornerRadius = 47.5
        self.workView.clipsToBounds = true
        self.workView.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 0.75)
        self.workView.alpha = 0
        self.scrollView.addSubview(workView)
        
        self.workView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.workView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 95))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.workView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 95))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.workView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.65, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.workView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 3.4, constant: 0))
        
        self.workView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(workTapped)))
        
        self.achievementsView.layer.cornerRadius = 60
        self.achievementsView.clipsToBounds = true
        self.achievementsView.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 0.55)
        self.achievementsView.alpha = 0
        self.scrollView.addSubview(achievementsView)
        
        self.achievementsView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.achievementsView, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 120))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.achievementsView, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 120))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.achievementsView, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 1.05, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.achievementsView, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 3.7, constant: 0))
        
        self.achievementsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(achievementsTapped)))
        
        
        self.wwdc2016View.layer.cornerRadius = 80
        self.wwdc2016View.clipsToBounds = true
        self.wwdc2016View.backgroundColor = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 0.75)
        self.wwdc2016View.alpha = 0
        self.scrollView.addSubview(wwdc2016View)
        
        self.wwdc2016View.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.wwdc2016View, attribute: .width, relatedBy: .equal, toItem: self.scrollView, attribute: .width, multiplier: 0, constant: 160))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.wwdc2016View, attribute: .height, relatedBy: .equal, toItem: self.scrollView, attribute: .height, multiplier: 0, constant: 160))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.wwdc2016View, attribute: .centerX, relatedBy: .equal, toItem: self.scrollView, attribute: .centerX, multiplier: 0.6, constant: 0))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.wwdc2016View, attribute: .centerY, relatedBy: .equal, toItem: self.scrollView, attribute: .centerY, multiplier: 2.375, constant: 0))
        
        self.wwdc2016View.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(wwdcTapped)))
    }
    
    func animateViews() {
        if self.counter == 0 {
            self.aboutMeView.alpha = 1
            self.projectsView.alpha = 1
            self.skillsView.alpha = 1
            self.workView.alpha = 1
            self.achievementsView.alpha = 1
            self.wwdc2016View.alpha = 1

            self.aboutMeView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
            self.projectsView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
            self.skillsView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
            self.workView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
            self.achievementsView.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
            self.wwdc2016View.popIn(fromScale: 5, duration: 0.6, delay: 0.5, completion: nil)
        }
    }
    
    func addTitleLabels() {
        self.aboutMeLabel.text = "About Me"
        self.aboutMeLabel.textColor = UIColor.white
        self.aboutMeLabel.font = UIFont(name: "SFUIText-Light", size: 22)
        self.aboutMeLabel.textAlignment = .center
        self.aboutMeView.addSubview(self.aboutMeLabel)
        
        self.aboutMeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.aboutMeLabel, attribute: .width, relatedBy: .equal, toItem: self.aboutMeView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.aboutMeLabel, attribute: .height, relatedBy: .equal, toItem: self.aboutMeView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.aboutMeLabel, attribute: .centerX, relatedBy: .equal, toItem: self.aboutMeView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.aboutMeLabel, attribute: .centerY, relatedBy: .equal, toItem: self.aboutMeView, attribute: .centerY, multiplier: 1.0, constant: 0.0))

        
        self.projectsLabel.text = "Projects"
        self.projectsLabel.textColor = UIColor.white
        self.projectsLabel.font = UIFont(name: "SFUIText-Light", size: 22)
        self.projectsLabel.textAlignment = .center
        self.projectsView.addSubview(self.projectsLabel)
        
        self.projectsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsLabel, attribute: .width, relatedBy: .equal, toItem: self.projectsView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsLabel, attribute: .height, relatedBy: .equal, toItem: self.projectsView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsLabel, attribute: .centerX, relatedBy: .equal, toItem: self.projectsView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.projectsLabel, attribute: .centerY, relatedBy: .equal, toItem: self.projectsView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        self.skillsLabel.text = "Skills"
        self.skillsLabel.textColor = UIColor.white
        self.skillsLabel.font = UIFont(name: "SFUIText-Light", size: 22)
        self.skillsLabel.textAlignment = .center
        self.skillsView.addSubview(self.skillsLabel)
        
        self.skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.skillsLabel, attribute: .width, relatedBy: .equal, toItem: self.skillsView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.skillsLabel, attribute: .height, relatedBy: .equal, toItem: self.skillsView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.skillsLabel, attribute: .centerX, relatedBy: .equal, toItem: self.skillsView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.skillsLabel, attribute: .centerY, relatedBy: .equal, toItem: self.skillsView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        self.workLabel.text = "Work"
        self.workLabel.textColor = UIColor.white
        self.workLabel.font = UIFont(name: "SFUIText-Light", size: 22)
        self.workLabel.textAlignment = .center
        self.workView.addSubview(self.workLabel)
        
        self.workLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.workLabel, attribute: .width, relatedBy: .equal, toItem: self.workView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.workLabel, attribute: .height, relatedBy: .equal, toItem: self.workView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.workLabel, attribute: .centerX, relatedBy: .equal, toItem: self.workView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.workLabel, attribute: .centerY, relatedBy: .equal, toItem: self.workView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        self.achievementsLabel.text = "Honors"
        self.achievementsLabel.textColor = UIColor.white
        self.achievementsLabel.font = UIFont(name: "SFUIText-Light", size: 22)
        self.achievementsLabel.textAlignment = .center
        self.achievementsView.addSubview(self.achievementsLabel)
        
        self.achievementsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.achievementsLabel, attribute: .width, relatedBy: .equal, toItem: self.achievementsView, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.achievementsLabel, attribute: .height, relatedBy: .equal, toItem: self.achievementsView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.achievementsLabel, attribute: .centerX, relatedBy: .equal, toItem: self.achievementsView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.achievementsLabel, attribute: .centerY, relatedBy: .equal, toItem: self.achievementsView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
        
        self.wwdc2016Label.text = "WWDC 2016"
        self.wwdc2016Label.textColor = UIColor.white
        self.wwdc2016Label.font = UIFont(name: "SFUIText-Light", size: 22)
        self.wwdc2016Label.textAlignment = .center
        self.wwdc2016Label.numberOfLines = 0
        self.wwdc2016View.addSubview(self.wwdc2016Label)
        
        self.wwdc2016Label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.wwdc2016Label, attribute: .width, relatedBy: .equal, toItem: self.wwdc2016View, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wwdc2016Label, attribute: .height, relatedBy: .equal, toItem: self.wwdc2016View, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wwdc2016Label, attribute: .centerX, relatedBy: .equal, toItem: self.wwdc2016View, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.wwdc2016Label, attribute: .centerY, relatedBy: .equal, toItem: self.wwdc2016View, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func aboutMeTapped() {
        print("called1")
        let transition = JTMaterialTransition(animatedView: self.aboutMeView)
        transition.startBackgroundColor = self.aboutMeView.backgroundColor
        let controller = UINavigationController(rootViewController: AboutMeViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    func projectsTapped() {
        print("called2")
        let transition = JTMaterialTransition(animatedView: self.projectsView)
        transition.startBackgroundColor = self.projectsView.backgroundColor
        let controller = UINavigationController(rootViewController: ProjectsViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    func skillsTapped() {
        print("called3")
        let transition = JTMaterialTransition(animatedView: self.skillsView)
        transition.startBackgroundColor = self.skillsView.backgroundColor
        let controller = UINavigationController(rootViewController: SkillsViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    func workTapped() {
        let transition = JTMaterialTransition(animatedView: self.workView)
        transition.startBackgroundColor = self.workView.backgroundColor
        let controller = UINavigationController(rootViewController: WorkViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    func achievementsTapped() {
        let transition = JTMaterialTransition(animatedView: self.achievementsView)
        transition.startBackgroundColor = self.achievementsView.backgroundColor
        let controller = UINavigationController(rootViewController: AchievementsViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
    
    func wwdcTapped() {
        print("called4")
        let transition = JTMaterialTransition(animatedView: self.wwdc2016View)
        transition.startBackgroundColor = self.wwdc2016View.backgroundColor
        let controller = UINavigationController(rootViewController: WWDCViewController())
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = transition
        self.present(controller, animated: true, completion: nil)
    }
}


extension ViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if previewingContext.sourceView == self.aboutMeView {
            return UINavigationController(rootViewController: AboutMeViewController())
        } else if previewingContext.sourceView == self.projectsView {
            return UINavigationController(rootViewController: ProjectsViewController())
           // return ProjectsViewController()
        } else if previewingContext.sourceView == self.skillsView {
            return UINavigationController(rootViewController: SkillsViewController())
        } else if previewingContext.sourceView == self.workView {
            return UINavigationController(rootViewController: WorkViewController())
        } else if previewingContext.sourceView == self.achievementsView {
            return UINavigationController(rootViewController: AchievementsViewController())
        } else {
            let wwdc = WWDCViewController()
            wwdc.isPeeking = true
            return UINavigationController(rootViewController: wwdc)
        }
    }
    
    @objc(previewingContext:commitViewController:)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func registerForce() {
        if traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.aboutMeView)
            self.registerForPreviewing(with: self, sourceView: self.projectsView)
            self.registerForPreviewing(with: self, sourceView: self.skillsView)
            self.registerForPreviewing(with: self, sourceView: self.workView)
            self.registerForPreviewing(with: self, sourceView: self.achievementsView)
            self.registerForPreviewing(with: self, sourceView: self.wwdc2016View)
        }
    }
}
