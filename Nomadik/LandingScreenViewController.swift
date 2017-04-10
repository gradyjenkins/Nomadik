 //
//  LandingScreenViewController.swift
//  Nomadik
//
//  Created by Grady Jenkins on 12/16/16.
//  Copyright © 2016 Monmouth University. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LandingScreenViewController: UIViewController {

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
    

    @IBAction func LoginAction(_ sender: AnyObject)
    {
        if self.emailField.text == "" || self.passwordField.text == ""
        {
            let alertController = UIAlertController(title: "Error!", message: "Enter a valid email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else
        {
            FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: {(user, error) in
                
                if error == nil
                {
                    self.emailField.text = user!.email
                    self.emailField.text = ""
                    self.passwordField.text = ""
                }
                else
                {
                    let alertController = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }

            })
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
