//
//  AccountViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

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
        
        nameLabel.text="Aiman Abdullah Anees"
        mobileNumberLabel.text="7760566874"
        fileNumberLabel.text="1050001"
        insuranceLabel.text="Bupa Life Insurance"
        addressLabel.text="Flat no:402, HGH Residency Hyderabad,Telangana"
        
        
        
        // Do any additional setup after loading the view.
    }

   

    }
