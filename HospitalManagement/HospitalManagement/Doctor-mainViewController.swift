//
//  Doctor-mainViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class Doctor_mainViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    var USERNAME = ""
    enum TabIndex: Int{
        case FirstChildTab = 0
        case SecondChildTab = 2
        case ThirdChildTab = 1
    }
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleViewController")
        return firstChildTabVC
    }()
    /*
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "PrescriptionViewController")
        return secondChildTabVC
    }()
    */
    lazy var thirdChildTabVC : UIViewController? = {
        let thirdChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "Doctor_accountViewController")
        return thirdChildTabVC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayCurrentTab(tabIndex: TabIndex.FirstChildTab.rawValue)
        print(USERNAME)
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
        //case TabIndex.SecondChildTab.rawValue :
          //  vc = secondChildTabVC
        case TabIndex.ThirdChildTab.rawValue :
            vc = thirdChildTabVC
        default:
            return nil
        }
        
        return vc
    }

    
    
              


    
    

    

    
}
