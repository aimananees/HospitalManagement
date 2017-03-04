//
//  DoctorsViewController.swift
//  HospitalManagement
//
//  Created by Aiman Abdullah Anees on 25/02/17.
//  Copyright © 2017 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class DoctorsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!
    
    let doctors=["DrAiman","DrSalman","DrFaisal","DrJohn","DrJim","DrRobert"]
    let hospitals=["Oak Crest Hospital","AIIMS Delhi","Gandhi Hospital","Oak Crest Hospital","Pune Hospital","AIIMS Delhi"]
    let doctorImage=["doctor"]
    let departments=["Cardiology","Neurology","Orthopedic","Cardiology","Orthopedic","Neurology"]
    
    var identities=["A"]
    
    
    var FilterDoctorSearch=[String]()
    var FilerHospital=[String]()
    //var FilterImageSearch=[String]()
    var resultSearchController=UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.resultSearchController=UISearchController(searchResultsController: nil)
        self.resultSearchController.searchResultsUpdater=self
        self.resultSearchController.dimsBackgroundDuringPresentation=false
        self.resultSearchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView=self.resultSearchController.searchBar
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive{
            return FilterDoctorSearch.count
        }
        else{
            return doctors.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            //cell?.textLabel?.text = names[indexPath.row]
            
            if self.resultSearchController.isActive{
                let imageView = cell?.viewWithTag(1) as! UIImageView
                imageView.image = UIImage(named: doctorImage[0])
                imageView.layer.cornerRadius = imageView.frame.size.width/2
                imageView.clipsToBounds=true
                imageView.layer.borderColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth=1
                
                
                let textView = cell?.viewWithTag(2) as! UILabel
                textView.text = FilterDoctorSearch[indexPath.row]
                
                let textView1 = cell?.viewWithTag(3) as! UILabel
                textView1.text = hospitals[indexPath.row]
                
                let textView2 = cell?.viewWithTag(4) as! UILabel
                textView2.text = departments[indexPath.row]
                
                
            }
            
            else{
                let imageView = cell?.viewWithTag(1) as! UIImageView
                imageView.image = UIImage(named: doctorImage[0])
                imageView.layer.cornerRadius = imageView.frame.size.width/2
                imageView.clipsToBounds=true
                imageView.layer.borderColor = UIColor.lightGray.cgColor
                imageView.layer.borderWidth=1
                
                let textView = cell?.viewWithTag(2) as! UILabel
                textView.text = doctors[indexPath.row]
                
                let textView1 = cell?.viewWithTag(3) as! UILabel
                textView1.text = hospitals[indexPath.row]
                
                let textView2 = cell?.viewWithTag(4) as! UILabel
                textView2.text = departments[indexPath.row]
            }
            
            return cell!
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vcName = identities[0]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        self.FilterDoctorSearch.removeAll(keepingCapacity: false)
        
        let searchPredicate=NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        
        let array=(self.doctors as NSArray).filtered(using: searchPredicate)
        
        self.FilterDoctorSearch=array as! [String]
        
        self.tableView.reloadData()
        
        
    }
    
    

    

}
