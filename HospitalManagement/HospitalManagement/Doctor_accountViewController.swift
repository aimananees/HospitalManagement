//
//  Doctor_accountViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

struct Firebasepull {
    let name : String!
    let phone : String!
    let department : String!
    let hospital : String!
    let image_url : String!
    let key: String!
    let username : String!
}

struct Firebasepull2 {
    let username : String!
    let slot1 : String!
    let slot2 : String!
    let slot3 : String!
    let key : String!
}


class Doctor_accountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorPhoneNumber: UILabel!
    @IBOutlet weak var doctorDepartment: UILabel!
    @IBOutlet weak var doctorHospital: UILabel!
    
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        if (LoginViewController.GlobalVariable_Doctor_Sign_in.username != ""){
            LoginViewController.GlobalVariable_Doctor_Sign_in.username=""
        }
        else{
            DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.username=""
        }
        
    }
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var appointments=[Firebasepull2]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child("appointments").observe(.childAdded, with: {(snapshot) in
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

        
        
        
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor = UIColor.darkGray.cgColor
        profileImage.layer.borderWidth=3
    
        if(DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.name != ""){
            
            doctorName.text = DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.name
            doctorPhoneNumber.text = DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.phone
            doctorDepartment.text = DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.department
            doctorHospital.text = DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.hospital
            
            let resource=ImageResource(downloadURL: URL(string: DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.image_url)!, cacheKey: DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.image_url)
            profileImage.kf.setImage(with: resource)
        }
        else{
            doctorName.text=LoginViewController.GlobalVariable_Doctor_Sign_in.name
            doctorPhoneNumber.text=LoginViewController.GlobalVariable_Doctor_Sign_in.phone
            doctorDepartment.text=LoginViewController.GlobalVariable_Doctor_Sign_in.department
            doctorHospital.text=LoginViewController.GlobalVariable_Doctor_Sign_in.hospital
            
            let resource=ImageResource(downloadURL: URL(string: LoginViewController.GlobalVariable_Doctor_Sign_in.image_url)!, cacheKey: LoginViewController.GlobalVariable_Doctor_Sign_in.image_url)
            
            profileImage.kf.setImage(with: resource)
        }
        
    }
    
   
    
    
    @IBAction func timelineTapped(_ sender: UIBarButtonItem) {
        
        
        let alertController=UIAlertController(title: "Timeline", message: "Daily Schedule", preferredStyle: .alert)
        
        let username : String!
        var key : String!
        var slot1 : String!
        var slot2 : String!
        var slot3 : String!
        
        if(DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.username != ""){
            
            username=DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.username
            var i:Int=0
            while(i<self.appointments.count){
                if(username == self.appointments[i].username){
                    
                    key=self.appointments[i].key
                    slot1=self.appointments[i].slot1
                    slot2=self.appointments[i].slot2
                    slot3=self.appointments[i].slot3
                }
                i=i+1
            }
            
            }
            
        else{
            username=LoginViewController.GlobalVariable_Doctor_Sign_in.username
            var i:Int=0
            while(i<self.appointments.count){
                if(username == self.appointments[i].username){
                    
                    key=self.appointments[i].key
                    slot1=self.appointments[i].slot1
                    slot2=self.appointments[i].slot2
                    slot3=self.appointments[i].slot3
                }
                i=i+1
            }
            
        }
        
        
        let updateAction=UIAlertAction(title: "Update", style: .default){(_) in
            let key=key
            let slot1=alertController.textFields?[0].text
            let slot2=alertController.textFields?[1].text
            let slot3=alertController.textFields?[2].text
            self.updateNote(key: key!, username:username,slot1:slot1!,slot2:slot2!,slot3:slot3!)
        }
    
        alertController.addTextField{(textField) in
            textField.text=slot1
        }
        alertController.addTextField{(textField) in
            textField.text=slot2
        }
        alertController.addTextField{(textField) in
            textField.text=slot3
        }

    
        alertController.addAction(updateAction)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        present(alertController,animated: true,completion: nil)
        
    }
    
    func updateNote(key:String,username:String,slot1:String,slot2:String,slot3:String){
        
        let note = [
            "key":key as AnyObject,
            "username":username as AnyObject,
            "slot1":slot1 as AnyObject,
            "slot2":slot2 as AnyObject,
            "slot3":slot3 as AnyObject
            ] as [String:AnyObject]
        
        ref?.child("appointments").child(key).setValue(note)
        
        
    }
    
    
    
   
}

