//
//  PrescriptionViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import MessageUI
import Firebase



class PrescriptionViewController: UIViewController,MFMailComposeViewControllerDelegate{

    var databaseRef:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?

    
    @IBOutlet var subject: UITextField!
    @IBOutlet var prescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var patientUsername = ScheduleViewController.Passing_Patient_Information.username
        patientUsername=patientUsername.replacingOccurrences(of: ".", with: "")
        patientUsername+="_prescription"
        databaseRef = FIRDatabase.database().reference().child(patientUsername)
        
        
    }

    @IBAction func sendMail(_ sender: UIButton) {
        if(LoginViewController.GlobalVariable_Doctor_Sign_in.username != ""){
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName":LoginViewController.GlobalVariable_Doctor_Sign_in.name as AnyObject,"subject":subject.text as AnyObject,"prescription":prescription.text as AnyObject]
            
            databaseRef?.child(key!).setValue(post)
           
            var alert = UIAlertController(title: "Prescription", message: "Prescription is sent successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            subject.text = ""
            prescription.text=""
            
        }
        else{
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName":DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.name as AnyObject,"subject":subject.text as AnyObject,"prescription":prescription.text as AnyObject]
            
            databaseRef?.child(key!).setValue(post)
            
            var alert = UIAlertController(title: "Prescription", message: "Prescription is sent successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            subject.text = ""
            prescription.text=""

        }

}
    
}
