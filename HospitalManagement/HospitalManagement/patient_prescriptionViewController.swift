//
//  patient_prescriptionViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 31/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase

struct Prescription{
    let doctorName : String!
    let subject : String!
    let presctiption : String!
}

class patient_prescriptionViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    var username : String!
    var prescriptions = [Prescription]()
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(PatientLoginViewController.GlobalVariable_Patient_Sign_In.username != ""){
            username=PatientLoginViewController.GlobalVariable_Patient_Sign_In.username
            username=username.replacingOccurrences(of: ".", with: "")
            username.append("_prescription")
            
        }
        else{
            username=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.username
            username=username.replacingOccurrences(of: ".", with: "")
            username.append("_prescription")
        }
        
        print(username)
        
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child(username).observe(.childAdded, with: {(snapshot) in
            
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let name=dictionary["doctorName"] as? String
                let subject=dictionary["subject"] as? String
                let prescription=dictionary["prescription"] as? String
                
                self.prescriptions.insert(Prescription(doctorName:name,subject:subject,presctiption:prescription), at: 0)
            self.tableview.reloadData()
            }
        }, withCancel:nil)
        
        self.tableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
    
        let textView = cell?.viewWithTag(1) as! UILabel
        textView.text = prescriptions[indexPath.row].doctorName
        
        let textView1 = cell?.viewWithTag(2) as! UILabel
        textView1.text = prescriptions[indexPath.row].subject
        
        return cell!
        
    }
    
    struct Patient_Prescription{
        static var pass_prescription = String()
        static var pass_subject = String()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Patient_Prescription.pass_prescription = prescriptions[indexPath.row].presctiption
        Patient_Prescription.pass_subject = prescriptions[indexPath.row].subject
        self.performSegue(withIdentifier: "show_prescription", sender: self)
        
        
    }
    
    

    
   

}
