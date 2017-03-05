//
//  PatientSignUpViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 02/03/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit
import Alamofire

class PatientSignUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var insurance: UITextField!
    @IBOutlet weak var address: UITextField!
    
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        profileImage.layer.cornerRadius=profileImage.frame.size.width/2
        profileImage.clipsToBounds=true
        
        profileImage.layer.borderColor=UIColor.lightGray.cgColor
        profileImage.layer.borderWidth=2

        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func submitButton(_ sender: UIButton) {
        
    }
    
    
}

