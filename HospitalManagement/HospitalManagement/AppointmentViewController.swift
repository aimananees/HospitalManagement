//
//  AppointmentViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class AppointmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    var appointments = [Appointments]()
    var username : String!
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    

    var names=[String]()
    var locationArray=["location-map-flat-1"]
    var doctorPhotoArray=["doctor"]
    var dayArray=["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        names=["1.30pm","4.30pm","2.30pm","12.20pm","5.30pm"]
        ref = FIRDatabase.database().reference()

        
        if(PatientLoginViewController.GlobalVariable_Patient_Sign_In.username != ""){
            username=PatientLoginViewController.GlobalVariable_Patient_Sign_In.username
            username=username.replacingOccurrences(of: ".", with: "")
        }
        else{
            username=PatientSignUpViewController.GlobalVariable_Patient_Sign_Up.username
            username=username.replacingOccurrences(of: ".", with: "")
            
        }
        
         databaseHandle=ref?.child(username).observe(.childAdded, with: {(snapshot) in
            
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
                
                
                
                self.appointments.insert(Appointments(doctorName: doctorName, doctorImage: doctorImage, doctorUsername: doctorUsername, key: key, patientImage: patientImage, patientName: patientName, patientUsername: patientUsername, time: time,patient_file_number:patient_file_number,patient_address:patient_address,patient_mobile_number:patient_mobile_number,patient_insurance:patient_insurance), at: 0)
            }
            self.TableView.reloadData()
        }, withCancel: nil)
        
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //cell?.textLabel?.text = names[indexPath.row]
        let imageView = cell?.viewWithTag(1) as! UIImageView
        let resource=ImageResource(downloadURL: URL(string: appointments[indexPath.row].doctorImage)!, cacheKey: appointments[indexPath.row].doctorImage)
        imageView.kf.setImage(with: resource)
        
        //imageView.image = UIImage(named: doctorPhotoArray[0])
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds=true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth=1
        
        let textView = cell?.viewWithTag(2) as! UILabel
        textView.text = appointments[indexPath.row].doctorName
        
        let locationImageView=cell?.viewWithTag(3) as! UIImageView
        locationImageView.image=UIImage(named: locationArray[0])
        
        let textView1 = cell?.viewWithTag(4) as! UILabel
        textView1.text = "Today"
        
        return cell!

        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    

   
}
