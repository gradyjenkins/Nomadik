//
//  NewDestinationViewController.swift
//  Nomadik
//
//  Created by Grady Jenkins on 4/10/17.
//  Copyright © 2017 Monmouth University. All rights reserved.
//

import UIKit
import Firebase

class NewDestinationViewController: UIViewController {
    
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    var ref: FIRDatabaseReference! = FIRDatabase.database().reference()
    var stateArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationsRef = self.ref.child("locations")
        locationsRef.observe(.value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                
            }
            
        }) { (Error) in
            print(Error.localizedDescription)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addLocation(_ sender: Any)
    {
        //Check if the fields are properly filled out, if not presents an alert.
        guard let state = stateField.text, let city = cityField.text, let latitude = latitudeField.text, let longitude = longitudeField.text else {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid location", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            return
        }
        //Gets the UID of the current logged in user
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        //Creates a new Location object given the fields that were entered
        let location = Location(state: state, city: city, longitude: longitude, latitude: latitude)
        
        
        self.ref.child("locations").childByAutoId().setValue(location)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
