//
//  DoctorSignUpViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SVProgressHUD





class DoctorSignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var hospital: UITextField!
    @IBOutlet weak var department: UITextField!
    
    var Url1:AnyObject!
    var imageData:UIImage!
    var username = ""
    var password = ""
    var re_password = ""
    var USERNAME:String!
    var NAME:String!
    var PHONENUMBER:String!
    var HOSPITAL:String!
    var DEPARTMENT:String!
    
    @IBOutlet var incorrect: UILabel!
    var imagePicker = UIImagePickerController()
    var databaseRef:FIRDatabaseReference!
    var databaseRef1:FIRDatabaseReference!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        USERNAME=username
        
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        profileImage.layer.cornerRadius=profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor=UIColor.lightGray.cgColor
        profileImage.layer.borderWidth=2
        print(username)
        print(password)
        print(re_password)
        
        print("*****************************************")
        databaseRef=FIRDatabase.database().reference().child("doctors_info")
        databaseRef1=FIRDatabase.database().reference().child("appointments")
    }


    
    
    @IBAction func registerButton(_ sender: UIButton) {
    }
    
    @IBAction func cameraPhoto(_ sender: UIBarButtonItem) {
        imagePicker.sourceType=UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func photoLibrary(_ sender: UIBarButtonItem) {
        imagePicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func uploadImageToFirebaseStorage(data:NSData){
        SVProgressHUD.show(withStatus: "Loading")
        UIApplication.shared.beginIgnoringInteractionEvents()
        var Timestamp: String {
            return "\(NSDate().timeIntervalSince1970 * 1000)"
        }
        DispatchQueue.global(qos:.background).async {
            let storageRef = FIRStorage.storage().reference(withPath: "\(Timestamp)")
            let uploadMetadata = FIRStorageMetadata()
            uploadMetadata.contentType = "image/jpeg"
            let uploadTask = storageRef.put(data as Data, metadata: uploadMetadata) {
                (metadata,error) in
                if(error != nil){
                    print(error?.localizedDescription)
                }
                else{
                    print(metadata)
                    let Url:URL = (metadata?.downloadURL())!
                    do{
                        print(Url)
                        var url_string:String = "\(Url)"
                        self.Url1 = url_string as AnyObject!
                        print(self.Url1)
                        SVProgressHUD.dismiss()
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                        
                    catch{
                        
                        print("Error")
                    }
                    
                    
                    
                }
                
            }
            uploadTask.observe(.progress) {[weak self] (snapshot) in
                guard let strongSelf = self else { return }
                guard let progress = snapshot.progress else{ return }
            }
            
            
        }
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        profileImage.image=info[UIImagePickerControllerOriginalImage] as? UIImage
        imageData=profileImage.image
        if let OriginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let imageData=UIImageJPEGRepresentation(OriginalImage, 0.8){
            uploadImageToFirebaseStorage(data: imageData as NSData)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    struct GlobalVariable_Doctor_Sign_Up{
        static var name = String()
        static var phone = String()
        static var department = String()
        static var hospital = String()
        static var key = String()
        static var image_url = String()
        static var username = String()

    }
    
    
    @IBAction func Register(_ sender: UIButton) {
       
        if name.text != "" && phoneNumber.text != "" && hospital.text != "" && department.text != ""{
            
                    //^^^^^^^POSTING OPERATION^^^^^^^^^
                    let key=self.databaseRef.childByAutoId().key
                    let key1=self.databaseRef1.childByAutoId().key
                    NAME=name.text
                    PHONENUMBER=phoneNumber.text
                    HOSPITAL=hospital.text
                    DEPARTMENT=department.text
                    
                    let post : [String : AnyObject] = ["username" : self.USERNAME as AnyObject,"name": NAME as AnyObject, "hospital" : HOSPITAL as AnyObject, "department" : DEPARTMENT as AnyObject,"image_url":self.Url1 as AnyObject,"employee_id":key as AnyObject,"phone":PHONENUMBER as AnyObject]
            
            let post1 : [String : AnyObject] = ["username" : self.USERNAME as AnyObject,"slot1":"" as AnyObject,"slot2":"" as AnyObject,"slot3":"" as AnyObject,"key":key1 as AnyObject]
            

            
                    
                    self.databaseRef.child(key).setValue(post)
                    self.databaseRef1.child(key1).setValue(post1)
            
                    GlobalVariable_Doctor_Sign_Up.name = NAME
                    GlobalVariable_Doctor_Sign_Up.phone = PHONENUMBER
                    GlobalVariable_Doctor_Sign_Up.department = DEPARTMENT
                    GlobalVariable_Doctor_Sign_Up.hospital = HOSPITAL
                    GlobalVariable_Doctor_Sign_Up.key = key
                    GlobalVariable_Doctor_Sign_Up.image_url = self.Url1 as! String
                    GlobalVariable_Doctor_Sign_Up.username = self.USERNAME
                    
                    let myVC = self.storyboard?.instantiateViewController(withIdentifier: "Doctor_mainViewController") as! Doctor_mainViewController
                    
                    myVC.USERNAME=self.username
            
                    //self.navigationController?.pushViewController(myVC, animated: true)
                    
            
                }
                else{
                    self.incorrect.text="Some fields are missing"
                    print(self.incorrect.text!)
                }
                
    }
    
}
