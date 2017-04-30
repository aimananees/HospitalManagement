//
//  LoginViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var register: UIButton!
    @IBOutlet var signIn: UIButton!
    @IBOutlet var incorrect: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    var doctors = [Firebasepull]()
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        username.layer.cornerRadius=3
        username.clipsToBounds=true
        password.layer.cornerRadius=3
        password.clipsToBounds=true
        signIn.layer.cornerRadius=3
        signIn.clipsToBounds=true
        register.layer.cornerRadius=3
        register.clipsToBounds=true
        password.isSecureTextEntry=true
        
        
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child("doctors_info").observe(.childAdded, with: {
            (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let name=dictionary["name"] as? String
                let phone=dictionary["phone"] as? String
                let department=dictionary["department"] as? String
                let hospital = dictionary["hospital"] as? String
                let key = dictionary["employee_id"] as? String
                let image_url=dictionary["image_url"] as? String
                let username=dictionary["username"] as? String
                
                self.doctors.insert(Firebasepull(name:name,phone:phone,department:department,hospital:hospital,image_url:image_url,key:key,username:username), at: 0)
            }
            
            
        }, withCancel:nil)
        
        
    }
    
    struct GlobalVariable_Doctor_Sign_in{
        static var name = String()
        static var phone = String()
        static var department = String()
        static var hospital = String()
        static var key = String()
        static var image_url = String()
        static var username = String()
    }

    
    @IBAction func signInTapped(_ sender: UIButton) {
        if username.text != "" && password.text != ""{
            
            FIRAuth.auth()?.signIn(withEmail: username.text!, password: password.text!, completion: {(user,error) in
                
                if error == nil{
                    
                    var i:Int = 0
                    while(i<self.doctors.count){
                        if(self.doctors[i].username == self.username.text!){
                            GlobalVariable_Doctor_Sign_in.name = self.doctors[i].name
                            GlobalVariable_Doctor_Sign_in.department = self.doctors[i].department
                            GlobalVariable_Doctor_Sign_in.key=self.doctors[i].key
                            GlobalVariable_Doctor_Sign_in.hospital=self.doctors[i].hospital
                            GlobalVariable_Doctor_Sign_in.image_url=self.doctors[i].image_url
                            GlobalVariable_Doctor_Sign_in.phone=self.doctors[i].phone
                            GlobalVariable_Doctor_Sign_in.username=self.doctors[i].username
                        }
                        i=i+1
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Doctor_mainViewController") as! Doctor_mainViewController
                    self.present(nextViewController, animated:true, completion:nil)
                }
                    
                else{
                    
                    self.incorrect.text=error?.localizedDescription
                    
                }
                
            })
        
        }
}
}
