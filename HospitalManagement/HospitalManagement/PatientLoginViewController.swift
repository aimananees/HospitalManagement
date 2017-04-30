//
//  PatientLoginViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase

struct Firebasepull1{
    let address : String!
    let file_number : String!
    let image_url : String!
    let insurance : String!
    let name : String!
    let phone : String!
    let username : String!
    
}
class PatientLoginViewController: UIViewController {
    
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?
    
    var patients = [Firebasepull1]()

    @IBOutlet var register: UIButton!
    @IBOutlet var signIn: UIButton!
    @IBOutlet var incorrect: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = .lightContent
        username.layer.cornerRadius=3
        username.clipsToBounds=true
        password.layer.cornerRadius=3
        password.clipsToBounds=true
        signIn.layer.cornerRadius=3
        signIn.clipsToBounds=true
        password.isSecureTextEntry=true
        register.layer.cornerRadius=3
        register.clipsToBounds=true
        
        //Firebase - GET Request
        ref = FIRDatabase.database().reference()
        databaseHandle=ref?.child("patients_info").observe(.childAdded, with: {(snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let address = dictionary["address"] as? String
                let file_number = dictionary["file_number"] as? String
                let image_url = dictionary["image_url"] as? String
                let insurance = dictionary["insurance"] as? String
                let name=dictionary["name"] as? String
                let phone=dictionary["phone"] as? String
                let username=dictionary["username"] as? String
                
                self.patients.insert(Firebasepull1(address : address,file_number : file_number,image_url : image_url,insurance : insurance,name : name,phone : phone,username :username), at: 0)
                
            }
        }, withCancel: nil)
        print("*********")
    }
    
    struct GlobalVariable_Patient_Sign_In{
        static var username = String()
        static var name = String()
        static var phone = String()
        static var insurance = String()
        static var image_url = String()
        static var file_number = String()
        static var address = String()
        
    }


    @IBAction func signInTapped(_ sender: UIButton) {
        
        if username.text != "" && password.text != ""{
            
            FIRAuth.auth()?.signIn(withEmail: username.text!, password: password.text!, completion: {(user,error) in
                
                if error == nil{
                    var i:Int = 0
                    while i < self.patients.count{
                        if(self.patients[i].username == self.username.text!){
                            GlobalVariable_Patient_Sign_In.name=self.patients[i].name
                            print("***********************")
                            print(GlobalVariable_Patient_Sign_In.name)
                            GlobalVariable_Patient_Sign_In.username=self.patients[i].username
                            GlobalVariable_Patient_Sign_In.phone=self.patients[i].phone
                            GlobalVariable_Patient_Sign_In.insurance=self.patients[i].insurance
                            GlobalVariable_Patient_Sign_In.image_url=self.patients[i].image_url
                            GlobalVariable_Patient_Sign_In.file_number=self.patients[i].file_number
                            GlobalVariable_Patient_Sign_In.address=self.patients[i].address
                        }
                        i=i+1
                    }
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.present(nextViewController, animated:true, completion:nil)
                }
                    
                else{
                    
                    self.incorrect.text=error?.localizedDescription
                    
                }
                
            })
            
        }
    }
    
}
