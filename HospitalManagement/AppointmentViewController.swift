//
//  AppointmentViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var TableView: UITableView!
    
    var names=[String]()
    var locationArray=["location-map-flat-1"]
    var doctorPhotoArray=["doctor"]
    var dayArray=["Monday","Tuesday","Wednesday","Thursday","Friday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        names=["1.30pm","4.30pm","2.30pm","12.20pm","5.30pm"]
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        //cell?.textLabel?.text = names[indexPath.row]
        let imageView = cell?.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: doctorPhotoArray[0])
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds=true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth=1
        
        let textView = cell?.viewWithTag(2) as! UILabel
        textView.text = names[indexPath.row]
        
        let locationImageView=cell?.viewWithTag(3) as! UIImageView
        locationImageView.image=UIImage(named: locationArray[0])
        
        let textView1 = cell?.viewWithTag(4) as! UILabel
        textView1.text = dayArray[indexPath.row]
        
        return cell!

        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    

   
}
