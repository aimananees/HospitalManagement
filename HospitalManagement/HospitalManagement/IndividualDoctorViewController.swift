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
    
    
    var ref3:FIRDatabaseReference?
    var databaseHandle3:FIRDatabaseHandle?
    var appointments = [Firebasepull2]()
    
    var username : String!
    var patient_username : String!
    var copyTime: String!
    
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
        
        //For updating the slot fields
        ref3 = FIRDatabase.database().reference()
        databaseHandle3=ref3?.child("appointments").observe(.childAdded, with: {(snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let username = dictionary["username"] as? String
                let slot1 = dictionary["slot1"] as? String
                let slot2 = dictionary["slot2"] as? String
                let slot3 = dictionary["slot3"] as? String
                let key = dictionary["key"] as? String
                self.appointments.insert(Firebasepull2(username:username,slot1:slot1,slot2:slot2,slot3:slot3,key:key), at: 0)
            }
        }, withCancel: nil)
        print("*********")

        
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
        copyTime=appointmentLabel.text
    }
    @IBAction func bookAppointment(_ sender: UIButton) {
        
        if(PatientLoginViewController.GlobalVariable_Patient_Sign_In.username != ""){
            if(appointmentLabel.text?.range(of: "(occupied") != nil){
                var alert = UIAlertController(title: "Sorry", message: "This slot is already taken up by other patient.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName" : DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.name  as AnyObject,"patientName": PatientLoginViewController.GlobalVariable_Patient_Sign_In.name as AnyObject, "patientUsername" : PatientLoginViewController.GlobalVariable_Patient_Sign_In.username as AnyObject, "doctorUsername" :  DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username as AnyObject,"time": appointmentLabel.text! as AnyObject,"key":key as AnyObject,"doctorImage":DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url as AnyObject,"patientImage":PatientLoginViewController.GlobalVariable_Patient_Sign_In.image_url as AnyObject,"patient_file_number":PatientLoginViewController.GlobalVariable_Patient_Sign_In.file_number as AnyObject,"patient_address":PatientLoginViewController.GlobalVariable_Patient_Sign_In.address as AnyObject,"patient_mobile_number":PatientLoginViewController.GlobalVariable_Patient_Sign_In.phone as AnyObject,"patient_insurance":PatientLoginViewController.GlobalVariable_Patient_Sign_In.insurance as AnyObject]
            
            
            databaseRef?.child(key!).setValue(post)
            databaseRef1?.child(key!).setValue(post)

            var i: Int = 0
            while(i<appointments.count){
                if (appointments[i].username == DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username){
                    if(appointments[i].slot1 == appointmentLabel.text!){
                        var updated_time = appointments[i].slot1 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": updated_time as AnyObject,
                            "slot2":appointments[i].slot2 as AnyObject,
                            "slot3":appointments[i].slot3 as AnyObject,
                            "username":appointments[i].username as AnyObject
                        ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        
                    }

                    else if(appointments[i].slot2 == appointmentLabel.text!){
                        var updated_time = appointments[i].slot2 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": appointments[i].slot1 as AnyObject,
                            "slot2":updated_time as AnyObject,
                            "slot3":appointments[i].slot3 as AnyObject,
                            "username":appointments[i].username as AnyObject
                            ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        

                        
                    }
                    else{
                        var updated_time = appointments[i].slot3 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": appointments[i].slot1 as AnyObject,
                            "slot2":appointments[i].slot2 as AnyObject,
                            "slot3":updated_time as AnyObject,
                            "username":appointments[i].username as AnyObject
                            ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        
                    }
                }
                i=i+1
            }
            
            var alert = UIAlertController(title: "Appointment", message: "Your Appointment is booked successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        
        else{
            if(appointmentLabel.text?.range(of: "(occupied") != nil){
                var alert = UIAlertController(title: "Sorry", message: "This slot is already taken up by other patient.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                
            
            
            let key=databaseRef?.childByAutoId().key
            let post : [String : AnyObject] = ["doctorName" : DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.name  as AnyObject,"patientName": PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.name as AnyObject, "patientUsername" : PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.username as AnyObject, "doctorUsername" :  DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.username as AnyObject,"time": appointmentLabel.text! as AnyObject,"key":key as AnyObject,"doctorImage":DoctorsViewController.GlobalVariable_Doctor_Appointment_Info.image_url as AnyObject,"patientImage":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.image_url as AnyObject,"patient_file_number":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.file_number as AnyObject,"patient_address":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.address as AnyObject,"patient_mobile_number":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.phone as AnyObject,"patient_insurance":PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.insurance as AnyObject]
            
            
            databaseRef?.child(key!).setValue(post)
            databaseRef1?.child(key!).setValue(post)
            
            var i: Int = 0
            while(i<appointments.count){
                if (appointments[i].username == DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.username){
                    if(appointments[i].slot1 == appointmentLabel.text!){
                        var updated_time = appointments[i].slot1 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": updated_time as AnyObject,
                            "slot2":appointments[i].slot2 as AnyObject,
                            "slot3":appointments[i].slot3 as AnyObject,
                            "username":appointments[i].username as AnyObject
                            ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        
                    }
                        
                    else if(appointments[i].slot2 == appointmentLabel.text!){
                        var updated_time = appointments[i].slot2 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": appointments[i].slot1 as AnyObject,
                            "slot2":updated_time as AnyObject,
                            "slot3":appointments[i].slot3 as AnyObject,
                            "username":appointments[i].username as AnyObject
                            ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        
                        
                        
                    }
                    else{
                        var updated_time = appointments[i].slot3 + "(occupied)"
                        let note = [
                            "key":appointments[i].key as AnyObject,
                            "slot1": appointments[i].slot1 as AnyObject,
                            "slot2":appointments[i].slot2 as AnyObject,
                            "slot3":updated_time as AnyObject,
                            "username":appointments[i].username as AnyObject
                            ] as [String:AnyObject]
                        ref3?.child("appointments").child(appointments[i].key).setValue(note)
                        
                    }
                }
                i=i+1
            }
            
            
            var alert = UIAlertController(title: "Appointment", message: "Your Appointment is booked successfully.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
            

        }
        
    }
    
}
