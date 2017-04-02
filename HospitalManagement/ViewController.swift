//
//  ViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 23/01/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
  
  
    
    enum TabIndex: Int{
        case FirstChildTab = 0
        case SecondChildTab = 1
        case ThirdChildTab = 2
        case ForthChildTab = 3
    }
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentViewController")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "DoctorsViewController")
        return secondChildTabVC
    }()
    lazy var thirdChildTabVC : UIViewController? = {
        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController")
        return thirdChildTabVC
    }()
    lazy var forthChildTabVC : UIViewController? = {
        let forthChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "patient_prescriptionViewController")
        return forthChildTabVC
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentTab(tabIndex: TabIndex.FirstChildTab.rawValue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        displayCurrentTab(tabIndex: sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(index: tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }

    
    
    

    func viewControllerForSelectedSegmentIndex(index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.FirstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.SecondChildTab.rawValue :
            vc = secondChildTabVC
        case TabIndex.ThirdChildTab.rawValue :
            vc = thirdChildTabVC
        case TabIndex.ForthChildTab.rawValue :
            vc = forthChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
    
}

