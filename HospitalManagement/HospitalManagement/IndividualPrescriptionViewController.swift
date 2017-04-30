//
//  IndividualPrescriptionViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 31/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class IndividualPrescriptionViewController: UIViewController {

    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var prescription: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        subject.text=patient_prescriptionViewController.Patient_Prescription.pass_subject
        
        prescription.text=patient_prescriptionViewController.Patient_Prescription.pass_prescription
    }

    
}
