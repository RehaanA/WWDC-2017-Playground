//
//  ProjectsDetailViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 2/20/17.
//  Copyright © 2017 Rehaan Advani. All rights reserved.
//

import UIKit
import StoreKit

class ProjectsDetailViewController: UIViewController, UIPageViewControllerDataSource, SKStoreProductViewControllerDelegate {
    var icon = UIImage()
    var name = String()
    var date = String()
    var desc = String()
    
    var iconImageView = UIImageView()
    var dateLabel = UILabel()
    var descLabel = UITextView()
    
    var phoneImageView = UIImageView()
    
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let pageControl = UIPageControl()
    var screenshots = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addIcon()
        self.addDescription()
        self.addPhone()
        self.addPageController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func navBar() {
        self.title = self.name
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        
        if self.name == "hiQ Elevate" {
            let barButton = UIBarButtonItem(image: UIImage(named: "appStore"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.appStore))
            self.navigationItem.rightBarButtonItem = barButton
        }
    }
    
    func appStore() {
        //Open app in app store
        //let url = URL(string: "https://itunes.apple.com/us/app/hiq-elevate/id1146211343?mt=8")!
        //UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        if #available(iOS 8.0, *) {
            self.openStoreWithIdentifier(id: "1146211343")
        } else {
            let url = URL(string: "https://itunes.apple.com/us/app/hiq-elevate/id1146211343?mt=8")!
            UIApplication.shared.open(url, options: ["":""], completionHandler: nil)
        }
    }
    
    func openStoreWithIdentifier(id: String) {
        let storeVC = SKStoreProductViewController()
        storeVC.delegate = self
        let params = [SKStoreProductParameterITunesItemIdentifier: id]
        storeVC.loadProduct(withParameters: params) { (loaded, error) in
            if loaded {
                DispatchQueue.main.async {
                    self.present(storeVC, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func addIcon() {
        self.iconImageView.image = self.icon
        self.iconImageView.contentMode = .scaleAspectFill
        self.iconImageView.layer.borderColor = UIColor.black.cgColor
        self.iconImageView.layer.borderWidth = 0.5
        self.iconImageView.layer.cornerRadius = 20
        self.iconImageView.clipsToBounds = true
        self.view.addSubview(self.iconImageView)
        
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.iconImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0, constant: 110))
        self.view.addConstraint(NSLayoutConstraint(item: self.iconImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0, constant: 110))
        self.view.addConstraint(NSLayoutConstraint(item: self.iconImageView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 15))
        self.view.addConstraint(NSLayoutConstraint(item: self.iconImageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 75))
    }
    
    func addDescription() {
        self.descLabel.text = self.desc
        self.descLabel.textAlignment = .left
        self.descLabel.font = UIFont(name: "SFUIText-Regular", size: 16)
        self.descLabel.textColor = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
        self.descLabel.isEditable = false
        self.descLabel.isSelectable = false
        let exclusionPath = UIBezierPath(rect: CGRect(x: self.iconImageView.bounds.minX, y: self.iconImageView.bounds.maxY, width: 120, height: 100))
        self.descLabel.textContainer.exclusionPaths = [exclusionPath]
        self.descLabel.backgroundColor = UIColor.clear
        self.view.addSubview(self.descLabel)
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.95, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.5, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.descLabel, attribute: .top, relatedBy: .equal, toItem: self.iconImageView, attribute: .top, multiplier: 1.0, constant: -4))
    }
    
    func addPhone() {
        self.phoneImageView.image = UIImage(named: "phone")
        self.phoneImageView.contentMode = .scaleAspectFill
        self.view.addSubview(self.phoneImageView)
        
        self.phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.phoneImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: -10))
        self.view.addConstraint(NSLayoutConstraint(item: self.phoneImageView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 0.6, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.phoneImageView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.phoneImageView, attribute: .top, relatedBy: .equal, toItem: self.descLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    func addPageController() {
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(0)
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [ProjectsDetailPageViewController], direction: .forward, animated: true, completion: nil)
        //self.pageViewController.view.frame = self.view.frame
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.backgroundColor = UIColor.clear
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.pageViewController.view, attribute: .width, relatedBy: .equal, toItem: self.phoneImageView, attribute: .width, multiplier: 1.0, constant: 20.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageViewController.view, attribute: .height, relatedBy: .equal, toItem: self.phoneImageView, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageViewController.view, attribute: .centerX, relatedBy: .equal, toItem: self.phoneImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageViewController.view, attribute: .top, relatedBy: .equal, toItem: self.phoneImageView, attribute: .top, multiplier: 1.0, constant: -5.0))
        
        self.pageControl.numberOfPages = self.screenshots.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.currentPageIndicatorTintColor = UIColor(hex: 0xd3d3d3)
        self.pageControl.addTarget(self, action: #selector(self.pageValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(self.pageControl)
        
        self.pageControl.bringSubview(toFront: self.view)
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .height, relatedBy: .equal
            , toItem: self.view, attribute: .height, multiplier: 0.0, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: -10))
    }
    
    func pageValueChanged(_ sender: UIPageControl) {
        pageControl.currentPage = sender.currentPage
        pageControl.updateCurrentPageDisplay()
    }
    
    func viewControllerAtIndex(_ index: Int) -> ProjectsDetailPageViewController {
        let vc = ProjectsDetailPageViewController()
        vc.pageIndex = index
        vc.screenshot.image = self.screenshots[index]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ProjectsDetailPageViewController
        var index = vc.pageIndex
        if index == 0 || index == NSNotFound {
            pageControl.currentPage = index
            pageControl.updateCurrentPageDisplay()
            return nil
        }
        pageControl.currentPage = index
        pageControl.updateCurrentPageDisplay()
        index -= 1
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ProjectsDetailPageViewController
        var index = vc.pageIndex
        if index == NSNotFound {
            return nil
        }
        pageControl.currentPage = index
        pageControl.updateCurrentPageDisplay()
        index += 1
        if index == self.screenshots.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
}
