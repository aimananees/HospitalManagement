//
//  IndividualPatientViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Kingfisher

class IndividualPatientViewController: UIViewController {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientNumber: UILabel!
    @IBOutlet weak var patientFileNumber: UILabel!
    @IBOutlet weak var patientInsurance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resource=ImageResource(downloadURL: URL(string: ScheduleViewController.Passing_Patient_Information.image_url)!, cacheKey:ScheduleViewController.Passing_Patient_Information.image_url)
        patientImage.kf.setImage(with: resource)
        
        patientImage.layer.cornerRadius = patientImage.frame.size.width/2
        patientImage.clipsToBounds=true
        
        patientImage.layer.borderColor = UIColor.darkGray.cgColor
        patientImage.layer.borderWidth=3
        
        patientName.text=ScheduleViewController.Passing_Patient_Information.name
        patientNumber.text=ScheduleViewController.Passing_Patient_Information.mobile
        patientInsurance.text=ScheduleViewController.Passing_Patient_Information.insurance
        patientFileNumber.text=ScheduleViewController.Passing_Patient_Information.file_number
        
        
        


       
    }

    
}
