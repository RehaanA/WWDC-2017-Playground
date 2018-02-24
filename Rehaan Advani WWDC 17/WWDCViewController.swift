//
//  WWDCViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/26/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit

class WWDCViewController: UIViewController, UIPageViewControllerDataSource {
    var index = 0
    var isPeeking = false
    var pageViewController = UIPageViewController()
    var imageArray = [UIImage(named: "albumCover"), UIImage(named: "orientation"), UIImage(named: "wwdcFood"), UIImage(named: "badge"), UIImage(named: "timCook"), UIImage(named: "selfie"), UIImage(named: "line"), UIImage(named: "outsideBillGraham"), UIImage(named: "scholars"), UIImage(named: "stage"), UIImage(named: "slideStat"), UIImage(named: "joke"), UIImage(named: "ios10"), UIImage(named: "moscone"), UIImage(named: "squadMoscone"), UIImage(named: "profileMoscone"), UIImage(named: "insideMoscone"), UIImage(named: "craig"), UIImage(named: "john"), UIImage(named: "bash")]
    var descArray = ["",
                     "This picture was taken during the scholarship orientation, where developers from Apple gave their insights into building elegant and mainstream applications.",
                     "There was also a great selection of food! My favorite food item would have to be the brownies. I a am obsessed with chocolate, and I found that this was one of the tastiest parts of the day!",
                     "I was extremely proud of my accomplishment of getting accepted into the WWDC scholarship program, and to have my very own badge indicating that I was a scholar was a great moment!",
                     "This picture was taken during the annual scholars group photo. However, to our surprise, Tim Cook surprised and took selfies!",
                     "The moment when I met Tim Cook was amazing! This is my selfie taken with him, something every student developer attending the conference aspires to do!",
                     "This picture was taken at 2 AM, when I was waiting in line with my friends in front of the Bill Graham Auditorium the night before the keynote. Waiting in line was one of the most memorable experiences I had, as I got to make many new friends and take several coffee stops at Starbucks!",
                     "At around 9 AM during the morning of the keynote, everyone was anxious to enter the auditorium after getting absolutely no sleep. The atmosphere during this moment was electrifying. I could sense everyone's eagerness.",
                     "All of the scholars at the front of the line got to know each other during the long night before the keynote. This was taken right before entering the auditorium. Everyone was happy to be there, and no one regretted waiting in line all night!",
                     "Upon finally entering the keynote hall, I managed to get amazing seats, right near the front. This is a picture of the artwork on the big screen.",
                     "This was one of the statistics that stood out to me the most. I couldn't believe that there has been over 130 billion app downloads. This is just a crazy fact, and I can't wait for it to grow even more!",
                     "While Craig was walking through Apple Pay on the Mac, he joked that one would have to carry their Mac to the NFC station for it to work.",
                     "This was my favorite part of the presentation, as iOS is the platform I use everyday, and I couldn't wait to see what Apple had in store.",
                     "In front of Moscone center in downtown San Francisco, the environment was vibrant, and I could tell that everyone was having a good time.",
                     "This is a group photo of the main group of friends I hung out with during the conference: Erik van der Plas, Amit Kalra, Klaas Schoenmaker, and Lennart Kerkvliet, all of whom are extremely talented developers.",
                     "This is an individual photo of me that was taken to commemorate my experience at WWDC.",
                     "This was taken inside of Moscone center with the huge WWDC banners. It really felt like a dream once I first stepped into the building.",
                     "I knew I couldn't leave without getting a photo with Craig. I have always looked up to Craig, because I really like the humor that he shows off during the keynotes. He really has a great personality!",
                     "The morning before the conference started, my group of friends and I met up with John Geleynse of Apple and ate breakfast with him.",
                     "This was taken during one of the most fun times of the week, known as the Bash. I really enjoyed the music of Good Charlotte, as well as the DJ!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addPageView()
        
        if self.isPeeking == false {
            let alert = UIAlertController(title: "Welcome", message: "Welcome to my photo album! It will take you through the journey of my experience at WWDC 2016! Navigate by swiping through the pages.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navBar() {
        self.title = ""
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationTitleFont = UIFont(name: "SFUIText-Regular", size: 20)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navigationTitleFont]
        
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        
        let close = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(self.close(sender:)))
        self.navigationItem.leftBarButtonItem = close
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    func close(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addPageView() {
        self.pageViewController.dataSource = self
        let startVC = self.viewControllerAtIndex(0)
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as! [WWDCDetailViewController], direction: .forward, animated: true, completion: nil)
        self.pageViewController.view.frame = self.view.frame
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.backgroundColor = UIColor.white
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
    }
    
    func viewControllerAtIndex(_ index: Int) -> WWDCDetailViewController {
        let vc: WWDCDetailViewController = WWDCDetailViewController()
        vc.pageIndex = index
        vc.imageView.image = self.imageArray[index]
        vc.descLabel.text = self.descArray[index]
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WWDCDetailViewController
        var index = vc.pageIndex
        if index == 0 || index == NSNotFound {
            return nil
        }
        index -= 1
        self.index = index
        
        if index != 0 {
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "SFUIText-Regular", size: 20)!]
        } else {
            self.navBar()
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! WWDCDetailViewController
        var index = vc.pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        self.index = index
        if index == self.imageArray.count {
            return nil
        }
        
        if index != 0 {
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName: UIFont(name: "SFUIText-Regular", size: 20)!]
            
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.imageArray.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
