//
//  ScheduleViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher

struct Appointments{
    let doctorName:String!
    let doctorImage:String!
    let doctorUsername:String!
    let key:String!
    let patientImage:String!
    let patientName:String!
    let patientUsername:String!
    let time:String!
    let patient_file_number:String!
    let patient_address:String!
    let patient_mobile_number:String!
    let patient_insurance:String!
}

class ScheduleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var username : String!
    
    //var filter_results=[Appointments]()
    
    var Name=["Aiman Abdullah Anees","Salman Shah","Faisal Anees","James","Robert"]
    var Timings=["9.30pm","4.30pm","2.30pm","10.00am","11.00am"]
    //ar Days=["Monday","Tuesday","Wednesday","Thursday","Friday"]
    var identities=["B"]
    
    var results=[Appointments]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let databaseRef = FIRDatabase.database().reference()
        let databaseRef1 = FIRDatabase.database().reference()
        
        
        if(LoginViewController.GlobalVariable_Doctor_Sign_in.username != ""){
            username=LoginViewController.GlobalVariable_Doctor_Sign_in.username
            username=username.replacingOccurrences(of: ".", with: "")
        }
        else{
            username=DoctorSignUpViewController.GlobalVariable_Doctor_Sign_Up.username
            username=username.replacingOccurrences(of: ".", with: "")

        }
        databaseRef.child(username).queryOrderedByKey().observe(.childAdded, with: {(snapshot) in
                
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
            self.tableView.reloadData()
            }, withCancel: nil)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let imageView = cell?.viewWithTag(1) as! UIImageView
        let resource=ImageResource(downloadURL: URL(string: results[indexPath.row].patientImage)!, cacheKey: results[indexPath.row].patientImage)
        imageView.kf.setImage(with: resource)
        //imageView.image = UIImage(named: "aiman")
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds=true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth=1
        
        let textView = cell?.viewWithTag(2) as! UILabel
        
        textView.text = results[indexPath.row].patientName
        
        let textView1 = cell?.viewWithTag(3) as! UILabel
        textView1.text = results[indexPath.row].time
        
        let textView2 = cell?.viewWithTag(4) as! UILabel
        textView2.text = "Today"
        
        return cell!
        
    }
    
    struct Passing_Patient_Information{
        static var mobile = String()
        static var image_url = String()
        static var address = String()
        static var file_number = String()
        static var name = String()
        static var insurance = String()
        static var username = String()
        
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "show", sender: self)
        Passing_Patient_Information.image_url=results[indexPath.row].patientImage
        Passing_Patient_Information.file_number=results[indexPath.row].patient_file_number
        Passing_Patient_Information.mobile=results[indexPath.row].patient_mobile_number
        Passing_Patient_Information.address=results[indexPath.row].patient_address
        Passing_Patient_Information.name=results[indexPath.row].patientName
        Passing_Patient_Information.insurance=results[indexPath.row].patient_insurance
        Passing_Patient_Information.username=results[indexPath.row].patientUsername
        
        
    }
    
    
}
