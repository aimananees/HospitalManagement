//
//  Doctor_accountViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class Doctor_accountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorPhoneNumber: UILabel!
    @IBOutlet weak var doctorDepartment: UILabel!
    @IBOutlet weak var doctorHospital: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor = UIColor.darkGray.cgColor
        profileImage.layer.borderWidth=3
        
        doctorName.text="DrAiman"
        doctorHospital.text="Oak Crest Hospital"
        doctorDepartment.text="Cardiology"
        doctorPhoneNumber.text="7760566874"

    }

   
    

   

}
