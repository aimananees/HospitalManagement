//
//  LoginViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIVisualEffectView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var LoginButtonLabel: UILabel!
    @IBOutlet weak var SignupButtonLabel: UILabel!
    
    
    override func viewDidLoad() {
        imageView.layer.cornerRadius=10
        imageView.clipsToBounds=true
        imageView.layer.borderColor=UIColor.darkGray.cgColor
        imageView.layer.borderWidth=2
        
        userName.layer.borderColor=UIColor.darkGray.cgColor
        userName.layer.borderWidth=1
        
        password.layer.borderColor=UIColor.darkGray.cgColor
        password.layer.borderWidth=1
        
        LoginButtonLabel.layer.cornerRadius=4
        LoginButtonLabel.clipsToBounds=true
        
        SignupButtonLabel.layer.cornerRadius=4
        SignupButtonLabel.clipsToBounds=true
        
        

    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        print("Hello")
    }
    
    

    
}
