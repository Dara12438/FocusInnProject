//
//  SignUpViewController.swift
//  FocusInn
//
//  Created by Dara Oseyemi (student LM) on 1/9/19.
//  Copyright © 2019 Dara Oseyemi (student LM). All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButtonTouchedUp(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil, error == nil {
                print("user created")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print(error.debugDescription)
            }
        }
        
        Auth.auth().createUser(withEmail: email, password: password){ user, error in
            if let _ = user {
                print("user created")
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    print("couldn't change name")
                })
            }
            else{
                print(error.debugDescription)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        userNameTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if userNameTextField.isFirstResponder {
            emailTextField.becomeFirstResponder()
        }
        else if emailTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            signUpButton.isEnabled = true
        }
        return true
    }

}
