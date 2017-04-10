//
//  TravelScreenViewController.swift
//  Nomadik
//
//  Created by Grady Jenkins on 12/16/16.
//  Copyright © 2016 Monmouth University. All rights reserved.
//

import UIKit
import Firebase

class TravelScreenViewController: UIViewController {

    var ref: FIRDatabaseReference!
    let segueID = "newDestination"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func TravelAction(_ sender: AnyObject)
    {
        let locationRef = FIRDatabase.database().reference().child("locations")
        
        locationRef.observe(.value) { (snapshot: FIRDataSnapshot) in
            if let allLocations = snapshot.value as? [String:AnyObject] {
                print("Does snapshot exist: \(snapshot.exists())")
                for key in allLocations.keys {
                    if let locationDetails = allLocations[key] as? [String:AnyObject] {
                        //print("Location = \(key)")
                        
                        if let city = locationDetails["city"] as? String {
                            print("City = \(city)")
                        }
                        
                    }
                }
            }
        }
    }

    
    @IBAction func addNewDestination(_ sender: Any)
    {
        performSegue(withIdentifier: segueID, sender: self)
    }
    
    @IBAction func LogoutAction(_ sender: AnyObject)
    {
        try! FIRAuth.auth()?.signOut()
        
        self.dismiss(animated: true, completion: {});
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
