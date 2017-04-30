//
//  DoctorsViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//
import UIKit
import Firebase
import Kingfisher


class DoctorsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var doctors = [Firebasepull]()
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var ref1:FIRDatabaseReference?
    var databaseHandle1:FIRDatabaseHandle?
    var appointments = [Firebasepull2]()
    
    //let doctors=["DrAiman","DrSalman","DrFaisal","DrJohn","DrJim","DrRobert"]
    let hospitals=["Oak Crest Hospital","AIIMS Delhi","Gandhi Hospital","Oak Crest Hospital","Pune Hospital","AIIMS Delhi"]
    let doctorImage=["doctor"]
    let departments=["Cardiology","Neurology","Orthopedic","Cardiology","Orthopedic","Neurology"]
    
    var identities=["A"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child("doctors_info").observe(.childAdded, with: {(snapshot) in
            
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let name=dictionary["name"] as? String
                let phone=dictionary["phone"] as? String
                let department=dictionary["department"] as? String
                let hospital = dictionary["hospital"] as? String
                let key = dictionary["employee_id"] as? String
                let image_url=dictionary["image_url"] as? String
                let username=dictionary["username"] as? String
                
                self.doctors.insert(Firebasepull(name:name,phone:phone,department:department,hospital:hospital,image_url:image_url,key:key,username:username), at: 0)
                
                self.tableView.reloadData()
            }
        }, withCancel:nil)
        
        
        
        ref1 = FIRDatabase.database().reference()
        databaseHandle1=ref1?.child("appointments").observe(.childAdded, with: {(snapshot) in
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return doctors.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
            let imageView = cell?.viewWithTag(1) as! UIImageView
            let resource=ImageResource(downloadURL: URL(string: doctors[indexPath.row].image_url)!, cacheKey: doctors[indexPath.row].image_url)

            imageView.kf.setImage(with: resource)
            imageView.layer.cornerRadius = imageView.frame.size.width/2
            imageView.clipsToBounds=true
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.layer.borderWidth=1
            
            let textView = cell?.viewWithTag(2) as! UILabel
            textView.text = doctors[indexPath.row].name
            
            let textView1 = cell?.viewWithTag(3) as! UILabel
            textView1.text = doctors[indexPath.row].hospital
            
            let textView2 = cell?.viewWithTag(4) as! UILabel
            textView2.text = doctors[indexPath.row].department
        
        return cell!
        
    }
    
    struct GlobalVariable_Doctor_Appointment_Info{
        static var name = String()
        static var image_url=String()
        static var username = String()
        static var key = String()
        static var slot1 = String()
        static var slot2 = String()
        static var slot3 = String()
        static var slots=[String]()
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalVariable_Doctor_Appointment_Info.name = doctors[indexPath.row].name
        GlobalVariable_Doctor_Appointment_Info.image_url=doctors[indexPath.row].image_url
        GlobalVariable_Doctor_Appointment_Info.username=doctors[indexPath.row].username
        
        var i:Int = 0
        var flag=0
        while(i<appointments.count){
            if(GlobalVariable_Doctor_Appointment_Info.username == self.appointments[i].username){
                    flag=1
                    GlobalVariable_Doctor_Appointment_Info.key = self.appointments[i].key
                    GlobalVariable_Doctor_Appointment_Info.slot1 = self.appointments[i].slot1
                    GlobalVariable_Doctor_Appointment_Info.slot2 = self.appointments[i].slot2
                    GlobalVariable_Doctor_Appointment_Info.slot3 = self.appointments[i].slot3
            }
            
            i=i+1
        }
        if(flag==0){
            GlobalVariable_Doctor_Appointment_Info.slot1 = ""
            GlobalVariable_Doctor_Appointment_Info.slot2 = ""
            GlobalVariable_Doctor_Appointment_Info.slot3 = ""
        }
        
    }
    
}
