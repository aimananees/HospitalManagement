//
//  IndividualDoctorViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class IndividualDoctorViewController: UIViewController {

    @IBOutlet weak var doctorImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doctorImage.layer.cornerRadius = doctorImage.frame.size.width/2
        doctorImage.clipsToBounds=true
        
        doctorImage.layer.borderColor = UIColor.darkGray.cgColor
        doctorImage.layer.borderWidth=3
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
