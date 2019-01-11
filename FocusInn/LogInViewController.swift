//
//  LogInViewController.swift
//  FocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/9/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logInButtonTouchedUp(_ sender: UIButton) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            logInButton.isEnabled = true
        }
        return true
    }
}
