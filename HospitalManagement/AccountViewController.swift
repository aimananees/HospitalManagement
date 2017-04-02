//
//  AccountViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Kingfisher

class AccountViewController: UIViewController {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var fileNumberLabel: UILabel!
    @IBOutlet weak var insuranceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor = UIColor.darkGray.cgColor
        profileImage.layer.borderWidth=3
        
        if(PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.name != ""){
            nameLabel.text=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.name
            mobileNumberLabel.text=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.phone
            fileNumberLabel.text=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.file_number
            insuranceLabel.text=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.insurance
            addressLabel.text=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.address
            
            let resource=ImageResource(downloadURL: URL(string: PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.image_url)!, cacheKey: PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.image_url)
            profileImage.kf.setImage(with: resource)
            
        }
        
        else{
            nameLabel.text=PatientLoginViewController.GlobalVariable_Patient_Sign_In.name
            mobileNumberLabel.text=PatientLoginViewController.GlobalVariable_Patient_Sign_In.phone
            fileNumberLabel.text=PatientLoginViewController.GlobalVariable_Patient_Sign_In.file_number
            insuranceLabel.text=PatientLoginViewController.GlobalVariable_Patient_Sign_In.insurance
            addressLabel.text=PatientLoginViewController.GlobalVariable_Patient_Sign_In.address
            
            let resource=ImageResource(downloadURL: URL(string: PatientLoginViewController.GlobalVariable_Patient_Sign_In.image_url)!, cacheKey: PatientLoginViewController.GlobalVariable_Patient_Sign_In.image_url)
            profileImage.kf.setImage(with: resource)

            

        }
        
        
        
        // Do any additional setup after loading the view.
    }

   

    }
