//
//  IndividualPatientViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Kingfisher
import Firebase


class IndividualPatientViewController: UIViewController {

    @IBOutlet weak var patientImage: UIImageView!
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var patientNumber: UILabel!
    @IBOutlet weak var patientFileNumber: UILabel!
    @IBOutlet weak var patientInsurance: UILabel!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var ref1:FIRDatabaseReference?
    var databaseHandle1:FIRDatabaseHandle?

    var results=[Appointments]()
    var results1=[Appointments]()
    
    var ref3:FIRDatabaseReference?
    var databaseHandle3:FIRDatabaseHandle?
    var appointments = [Firebasepull2]()

    
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
        
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child(ScheduleViewController.Passing_Patient_Information.doctor_username).observe(.childAdded, with: {(snapshot) in

            print(snapshot)
            
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let doctorName = dictionary["doctorName"] as? String
                let doctorImage = dictionary["doctorImage"] as? String
                let doctorUsername = dictionary["doctorUsername"] as? String
                let patientImage = dictionary["patientImage"] as? String
                let patientName = dictionary["patientName"] as? String
                let patientUsername = dictionary["patientUsername"] as? String
                let time = dictionary["time"] as? String
                let key=dictionary["key"] as? String
                let patient_file_number = dictionary["patient_file_number"] as? String
                let patient_address = dictionary["patient_address"] as? String
                let patient_mobile_number = dictionary["patient_mobile_number"] as? String
                let patient_insurance = dictionary["patient_insurance"] as? String
                
                
                
                self.results.insert(Appointments(doctorName: doctorName, doctorImage: doctorImage, doctorUsername: doctorUsername, key: key, patientImage: patientImage, patientName: patientName, patientUsername: patientUsername, time: time,patient_file_number:patient_file_number,patient_address:patient_address,patient_mobile_number:patient_mobile_number,patient_insurance:patient_insurance), at: 0)
            }
        }, withCancel: nil)
        
        
        ref1 = FIRDatabase.database().reference()
        databaseHandle1=ref1?.child(ScheduleViewController.Passing_Patient_Information.username).observe(.childAdded, with: {(snapshot) in
                print(snapshot)
            
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let doctorName = dictionary["doctorName"] as? String
                let doctorImage = dictionary["doctorImage"] as? String
                let doctorUsername = dictionary["doctorUsername"] as? String
                let patientImage = dictionary["patientImage"] as? String
                let patientName = dictionary["patientName"] as? String
                let patientUsername = dictionary["patientUsername"] as? String
                let time = dictionary["time"] as? String
                let key=dictionary["key"] as? String
                let patient_file_number = dictionary["patient_file_number"] as? String
                let patient_address = dictionary["patient_address"] as? String
                let patient_mobile_number = dictionary["patient_mobile_number"] as? String
                let patient_insurance = dictionary["patient_insurance"] as? String
                
                
                
                self.results.insert(Appointments(doctorName: doctorName, doctorImage: doctorImage, doctorUsername: doctorUsername, key: key, patientImage: patientImage, patientName: patientName, patientUsername: patientUsername, time: time,patient_file_number:patient_file_number,patient_address:patient_address,patient_mobile_number:patient_mobile_number,patient_insurance:patient_insurance), at: 0)
            }
        }, withCancel: nil)
        
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

    }

    @IBAction func removingFromSchedule(_ sender: UIBarButtonItem) {
        var i: Int = 0
        while(i<results.count){
            if(results[i].doctorUsername == ScheduleViewController.Passing_Patient_Information.doctor_username && results[i].time == ScheduleViewController.Passing_Patient_Information.time){
                ref?.child(ScheduleViewController.Passing_Patient_Information.doctor_username).child(results[i].key).setValue(nil)
            }
            i=i+1
        }
        
        var j: Int = 0
        while(j<results1.count){
            if(results1[i].patientUsername == ScheduleViewController.Passing_Patient_Information.username && results1[i].time == ScheduleViewController.Passing_Patient_Information.time){
                ref1?.child(ScheduleViewController.Passing_Patient_Information.username).child(results1[i].key).setValue(nil)

            }
            j=j+1
        }
        
        var k: Int = 0
        var conditionChecker = ScheduleViewController.Passing_Patient_Information.time + "(occupied)"
        
        while(k<appointments.count){
            if(appointments[i].username == ScheduleViewController.Passing_Patient_Information.doctor_username){
                if(appointments[i].slot1 == conditionChecker){
                    let note = [
                        "key":appointments[i].key as AnyObject,
                        "slot1": conditionChecker.replacingOccurrences(of: "(occupied)", with: "") as AnyObject,
                        "slot2": appointments[i].slot2 as AnyObject,
                        "slot3":appointments[i].slot3 as AnyObject,
                        "username":appointments[i].username as AnyObject
                        ] as [String:AnyObject]
                    ref3?.child("appointments").child(appointments[i].key).setValue(note)
                    
                    
                }
                else if(appointments[i].slot2 == conditionChecker){
                    let note = [
                        "key":appointments[i].key as AnyObject,
                        "slot1": appointments[i].slot1 as AnyObject,
                        "slot2": conditionChecker.replacingOccurrences(of: "(occupied)", with: "") as AnyObject,
                        "slot3":appointments[i].slot3 as AnyObject,
                        "username":appointments[i].username as AnyObject
                        ] as [String:AnyObject]
                    ref3?.child("appointments").child(appointments[i].key).setValue(note)
                }
                else{
                    let note = [
                        "key":appointments[i].key as AnyObject,
                        "slot1": appointments[i].slot1 as AnyObject,
                        "slot2": appointments[i].slot2 as AnyObject,
                        "slot3": conditionChecker.replacingOccurrences(of: "(occupied)", with: "") as AnyObject,
                        "username":appointments[i].username as AnyObject
                        ] as [String:AnyObject]
                    ref3?.child("appointments").child(appointments[i].key).setValue(note)
                }
            }
            k=k+1
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    
}
