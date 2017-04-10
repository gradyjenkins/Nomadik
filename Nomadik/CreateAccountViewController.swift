//
//  CreateAccountViewController.swift
//  Nomadik
//
//  Created by Grady Jenkins on 12/16/16.
//  Copyright © 2016 Monmouth University. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountViewController: UIViewController {

    let successSegue = "accountSuccessSegue"
    let ref:FIRDatabaseReference! = FIRDatabase.database().reference()
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CreateAccountAction(_ sender: AnyObject)
    {
        guard let email = emailField.text, let password = passwordField.text else {
            defer {
                print("error with creating account")
            }
            let alertController = UIAlertController(title: "Error!", message: "Please check the fields for proper entry", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                //Present a success alert and reset fields to be empty
                self.emailField.text = ""
                self.passwordField.text = ""
                let alertController = UIAlertController(title: "Success!", message: "Successfully created an account.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                    return
                }
                
                //Save new user to database
                self.ref.child("users").child(uid).setValue(["email":email])
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        
        if(FIRAuth.auth()?.currentUser?.uid != nil){
            performSegue(withIdentifier: successSegue, sender: self)
        }
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
