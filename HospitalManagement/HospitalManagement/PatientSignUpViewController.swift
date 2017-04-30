//
//  PatientSignUpViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class PatientSignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var insurance: UITextField!
    @IBOutlet weak var address: UITextField!
    var username = ""
    var password = ""
    var re_password = ""
    
    var imageData:UIImage!
    var NAME:String!
    var PHONENUMBER: String!
    var INSURANCE: String!
    var ADDRESS: String!
    var Url1: AnyObject!
    var imagePicker = UIImagePickerController()
    var databaseRef:FIRDatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        profileImage.layer.cornerRadius=profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor=UIColor.lightGray.cgColor
        profileImage.layer.borderWidth=2

        // Do any additional setup after loading the view.
        databaseRef=FIRDatabase.database().reference().child("patients_info")
    }

    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        imagePicker.sourceType=UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    @IBAction func photoLibrary(_ sender: UIBarButtonItem) {
        imagePicker.sourceType=UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
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
    
    struct GlobalVariable_Patient_Sign_Up{
        static var username = String()
        static var name = String()
        static var phone = String()
        static var insurance = String()
        static var image_url = String()
        static var file_number = String()
        static var address = String()
        
    }


    @IBAction func submitButton(_ sender: UIButton) {
        
        if name.text != "" && phoneNumber.text != "" && insurance.text != "" && address.text != ""{
            
            //^^^^^^^POSTING OPERATION^^^^^^^^^
            let key=self.databaseRef.childByAutoId().key
            NAME=name.text
            PHONENUMBER=phoneNumber.text
            INSURANCE=insurance.text
            ADDRESS=address.text
            
            let post : [String : AnyObject] = ["username" : self.username as AnyObject,"name": NAME as AnyObject, "phone" : PHONENUMBER as AnyObject, "insurance" : INSURANCE as AnyObject,"image_url":self.Url1 as AnyObject,"file_number":key as AnyObject,"address":ADDRESS as AnyObject]
            
            self.databaseRef.child(key).setValue(post)
            
            GlobalVariable_Patient_Sign_Up.username = self.username
            GlobalVariable_Patient_Sign_Up.name = NAME
            GlobalVariable_Patient_Sign_Up.phone = PHONENUMBER
            GlobalVariable_Patient_Sign_Up.insurance = INSURANCE
            GlobalVariable_Patient_Sign_Up.image_url = self.Url1 as! String
            GlobalVariable_Patient_Sign_Up.file_number = key
            GlobalVariable_Patient_Sign_Up.address = ADDRESS
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            self.present(nextViewController, animated:true, completion:nil)
            
            
            
        }
    }


}

