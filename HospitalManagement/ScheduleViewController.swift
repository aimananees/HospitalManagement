//
//  ScheduleViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 26/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var Name=["Aiman Abdullah Anees","Salman Shah","Faisal Anees","James","Robert"]
    var Timings=["9.30pm","4.30pm","2.30pm","10.00am","11.00am"]
    var Days=["Monday","Tuesday","Wednesday","Thursday","Friday"]
    var identities=["B"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let imageView = cell?.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: "aiman")
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.clipsToBounds=true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth=1
        
        let textView = cell?.viewWithTag(2) as! UILabel
        textView.text = Name[indexPath.row]
        
        let textView1 = cell?.viewWithTag(3) as! UILabel
        textView1.text = Timings[indexPath.row]
        
        let textView2 = cell?.viewWithTag(4) as! UILabel
        textView2.text = Days[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = identities[0]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
}
