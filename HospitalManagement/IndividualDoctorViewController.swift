//
//  IndividualDoctorViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase

class IndividualDoctorViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var doctorImage: UIImageView!
    
    @IBOutlet var appointmentLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    var databaseRef:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var databaseRef1:FIRDatabaseReference?
    var databaseHandle1:FIRDatabaseHandle?
    
    var username : String!
    var patient_username : String!
    
    var sample=[String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        sample=[DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.slot1,DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.slot2,DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.slot3]
        
        pickerView.delegate=self
        pickerView.dataSource=self
        
        print(sample)
        print(DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.slot1)

        
        nameLabel.text = DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.name
        print(DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.key)
        
        doctorImage.layer.cornerRadius = doctorImage.frame.size.width/2
        doctorImage.clipsToBounds=true
        
        doctorImage.layer.borderColor = UIColor.darkGray.cgColor
        doctorImage.layer.borderWidth=3
        
        let resource=ImageResource(downloadURL: URL(string: DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url)!, cacheKey: DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url)
        
        doctorImage.kf.setImage(with: resource)
        username = DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username
        print(username)
        username=username.replacingOccurrences(of: ".", with: "")
        databaseRef=FIRDatabase.database().reference().child(username)
        if(PatientLoginViewController.GlobalVariable_Patient_Sign_In.username != ""){
            patient_username = PatientLoginViewController.GlobalVariable_Patient_Sign_In.username
            patient_username = patient_username.replacingOccurrences(of: ".", with: "")
        }
        else{
            patient_username=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.username
            patient_username = patient_username.replacingOccurrences(of: ".", with: "")
        }
         databaseRef1=FIRDatabase.database().reference().child(patient_username)
    }
    
    struct username_extracter{
        static var Doctor_username = String()
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sample.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sample[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        appointmentLabel.text=sample[row]
    }
    @IBAction func bookAppointment(_ sender: UIButton) {
        if(PatientLoginViewController.GlobalVariable_Patient_Sign_In.username != ""){
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName" : DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.name  as AnyObject,"patientName": PatientLoginViewController.GlobalVariable_Patient_Sign_In.name as AnyObject, "patientUsername" : PatientLoginViewController.GlobalVariable_Patient_Sign_In.username as AnyObject, "doctorUsername" :  DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username as AnyObject,"time": appointmentLabel.text! as AnyObject,"key":key as AnyObject,"doctorImage":DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url as AnyObject,"patientImage":PatientLoginViewController.GlobalVariable_Patient_Sign_In.image_url as AnyObject,"patient_file_number":PatientLoginViewController.GlobalVariable_Patient_Sign_In.file_number as AnyObject,"patient_address":PatientLoginViewController.GlobalVariable_Patient_Sign_In.address as AnyObject,"patient_mobile_number":PatientLoginViewController.GlobalVariable_Patient_Sign_In.phone as AnyObject,"patient_insurance":PatientLoginViewController.GlobalVariable_Patient_Sign_In.insurance as AnyObject]
            
            
            databaseRef?.child(key!).setValue(post)
            databaseRef1?.child(key!).setValue(post)
            
            var alert = UIAlertController(title: "Appointment", message: "Your Appointment is booked successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    
        }
        else{
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName" : DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.name  as AnyObject,"patientName": PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.name as AnyObject, "patientUsername" : PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.username as AnyObject, "doctorUsername" :  DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username as AnyObject,"time": appointmentLabel.text! as AnyObject,"key":key as AnyObject,"doctorImage":DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url as AnyObject,"patientImage":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.image_url as AnyObject,"patient_file_number":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.file_number as AnyObject,"patient_address":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.address as AnyObject,"patient_mobile_number":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.phone as AnyObject,"patient_insurance":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.insurance as AnyObject]
            
            
            databaseRef?.child(key!).setValue(post)
            databaseRef1?.child(key!).setValue(post)
            
            var alert = UIAlertController(title: "Appointment", message: "Your Appointment is booked successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            

        }
        
    }
    
}
