//
//  ProjectsViewController.swift
//  Rehaan Advani WWDC 17
//
//  Created by Rehaan Advani on 11/26/16.
//  Copyright © 2016 Rehaan Advani. All rights reserved.
//

import UIKit

class ProjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var wallpaper = UIImageView()
    var visualEffectView = UIVisualEffectView()
    var collectionView: UICollectionView!
    var tableView = UITableView()
    var icons = [UIImage(named: "hiqLogo"), UIImage(named: "p+"), UIImage(named: "wwdc16Logo"), UIImage(named: "wwdc15Logo"), UIImage(named: "Stock"), UIImage(named: "Contrameter")]
    var names = ["hiQ Elevate", "Performance+", "WWDC 2016", "WWDC 2015", "Stock Viewer", "Contrameter"]
    var dates = ["Jun 2016 - Oct 2016", "Jun 2015 - Aug 2015", "Mar 2016 - Apr 2016", "Mar 2015 - Apr 2015", "Feb 2016 - Present", "Jun 2016 - Jul 2016"]
    var descs = ["hiQ Elevate is an interactive itinerary for conference attendees at hiQ Elevate. The app gives attendees access to the most up to date information regarding the conference, including the agenda, locations, awards, etc. It also has unique features such as live tweeting, sharing one's profile, etc.", "Performance+ is a performance management application that allows managers to provide feedback to their employees. It allows managers to set goals and track them over time, give direct feedback, schedule meetings, and it also allows employees to log on and view their progress.", "This app was created last year as my application to WWDC 2016. It utilized Apple's latest technologies such as 3D Touch, Maps, and other developer frameworks. It is essentially an interactive resume with lots of information about me. This application was accepted into the scholarship program.", "This app was created two years ago as my application to WWDC 2015. It utilized Apple's latest technologies and other developer frameworks. It is essentially an interactive resume with lots of information about me, including education, work experience, etc.", "This is a project that I am currently working on in my AP CS class with a a small group. This app essentially gathers important stock data from an API, displays it, and provides relevant news regarding each stock that has a spike in their shares.", "I created this app, Contrameter, with a friend I met at WWDC last year, named Erik. This app essentially takes any two colors as an input, and calculates their contrast ratio. This is an extremely important component of UI design, and has proven to be useful."]
    var screenshots = [[UIImage(named: "hiq_3"), UIImage(named: "hiq_2"), UIImage(named: "hiq_1")],
                       [UIImage(named: "p+_1"), UIImage(named: "p+_2"), UIImage(named: "p+_3"),
                        UIImage(named: "p+_4"), UIImage(named: "p+_5")],
                       [UIImage(named: "wwdc16_1"), UIImage(named: "wwdc16_2"), UIImage(named: "wwdc16_3")],
                       [UIImage(named: "wwdc15_1"), UIImage(named: "wwdc15_2"), UIImage(named: "wwdc15_3")],
                       [UIImage(named: "stock_1")],
                       [UIImage(named: "contrameter_1")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBar()
        self.addTableView()
        //self.registerForce()
    }
    
    func navBar() {
        self.title = "Projects"
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
    
    func addTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ProjectsTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        self.tableView.isScrollEnabled = false
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProjectsTableViewCell! = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProjectsTableViewCell
        
        cell.icon.image = self.icons[indexPath.row]
        cell.nameLabel.text = self.names[indexPath.row]
        cell.dateLabel.text = self.dates[indexPath.row]
        cell.descLabel.text = self.descs[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = ProjectsDetailViewController()
        detailView.icon = self.icons[indexPath.row]!
        detailView.name = self.names[indexPath.row]
        detailView.date = self.dates[indexPath.row]
        detailView.desc = self.descs[indexPath.row]
        detailView.screenshots = self.screenshots[indexPath.row] as! [UIImage]
        self.navigationController?.pushViewController(detailView, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let initialFrame = self.tableView.rectForRow(at: indexPath)
        cell.frame = CGRect(x: 0-initialFrame.size.width, y: initialFrame.origin.y, width: initialFrame.size.width, height: initialFrame.size.height)
        UIView.animate(withDuration: 0.75, delay: 0.1*Double(indexPath.row), usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .curveLinear, animations: {
            cell.frame = initialFrame
        }, completion: nil)
    }
}

/*extension ProjectsViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = ProjectsDetailViewController()
        let indexPath = self.tableView.indexPathForRow(at: location)
        vc.icon = self.icons[(indexPath?.row)!]!
        vc.name = self.names[(indexPath?.row)!]
        vc.date = self.dates[(indexPath?.row)!]
        vc.desc = self.descs[(indexPath?.row)!]
        vc.screenshots = self.screenshots[(indexPath?.row)!] as! [UIImage]
        previewingContext.sourceRect = (self.tableView.cellForRow(at: indexPath!)?.frame)!
        return vc
    }
    
    @objc(previewingContext:commitViewController:)
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    func registerForce() {
        if traitCollection.forceTouchCapability == .available {
            self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
}*/
