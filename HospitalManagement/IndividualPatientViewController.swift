//
//  IndividualPatientViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class IndividualPatientViewController: UIViewController {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientNumber: UILabel!
    @IBOutlet weak var patientFileNumber: UILabel!
    @IBOutlet weak var patientInsurance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientImage.layer.cornerRadius = patientImage.frame.size.width/2
        patientImage.clipsToBounds=true
        
        patientImage.layer.borderColor = UIColor.darkGray.cgColor
        patientImage.layer.borderWidth=3
        
        patientName.text="Aiman Abdullah Anees"
        patientNumber.text="7760566874"
        patientInsurance.text="Bupa Life Insurance"
        patientFileNumber.text="15000101"
        


       
    }

    
}
