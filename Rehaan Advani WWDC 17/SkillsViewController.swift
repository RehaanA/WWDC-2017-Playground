//
//  SkillsViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/26/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit
import KDCircularProgress
import BAFluidView

class SkillsViewController: UIViewController, UIPageViewControllerDataSource {
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let percs = [0.75, 0.7, 0.6, 0.7, 0.65, 0.5, 0.2]
    let names = ["Swift", "Java", "Objective-C", "HTML", "CSS", "Python", "JavaScript"]
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addPageView()
    }
    
    func navBar() {
        self.title = "Skills"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 0.55)
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.closeView(sender:)))
        self.navigationItem.leftBarButtonItem = close
        
    }
    
    func closeView(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addPageView() {
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(0)
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [SkillsDetailViewController], direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = self.view.frame
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.backgroundColor = UIColor.white
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        self.pageControl.numberOfPages = self.percs.count
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.darkGray
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.pageControl.addTarget(self, action: #selector(self.pageValueChanged(_:)), for: .valueChanged)
        self.view.addSubview(self.pageControl)
        
        self.pageControl.bringSubview(toFront: self.view)
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .height, relatedBy: .equal
            , toItem: self.view, attribute: .height, multiplier: 0.0, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.pageControl, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.9, constant: 0.0))
    }
    
    func pageValueChanged(_ sender: UIPageControl) {
        pageControl.currentPage = sender.currentPage
        pageControl.updateCurrentPageDisplay()
    }
    
    func viewControllerAtIndex(_ index: Int) -> SkillsDetailViewController {
        let vc: SkillsDetailViewController = SkillsDetailViewController()
        vc.pageIndex = index
        //vc.nameLabel.text = self.names[index]
        //vc.percLabel.text = String(percs[index] * 100) + "%"
        //vc.fluidView.fill(to: self.percs[index] as NSNumber!)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! SkillsDetailViewController
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
        let vc = viewController as! SkillsDetailViewController
        var index = vc.pageIndex
        if index == NSNotFound {
            return nil
        }
        pageControl.currentPage = index
        pageControl.updateCurrentPageDisplay()
        index += 1
        if index == self.percs.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
}
