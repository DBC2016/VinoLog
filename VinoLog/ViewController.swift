//
//  ViewController.swift
//  VinoLog
//
//  Created by Demond Childers on 5/19/16.
//  Copyright © 2016 Demond Childers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    
    
    let backendless = Backendless.sharedInstance()
    let loginManager = LoginManager.sharedInstance
    var currentUser = BackendlessUser()
    
    
    
    //IBActions for Login Screen
    
    
    @IBOutlet private weak var emailEntry           :UITextField!
    @IBOutlet private weak var passwordEntry        :UITextField!
    @IBOutlet private weak var userRegister         :UIButton!
    @IBOutlet private weak var userLogIn            :UIButton!
    
    
    
    
    //MARK: - USER LOGIN METHODS
    
    @IBAction func loginButtonPressed(button: UIButton) {
        guard let email = emailEntry.text else {
            return
        }
        guard let password = passwordEntry.text else {
            return
        }
        
        loginManager.loginUser(email, password: password)
    }
    
    @IBAction func signUpButtonPressed(button: UIButton) {
        guard let email = emailEntry.text else {
            return
        }
        guard let password = passwordEntry.text else {
            return
        }
        
        loginManager.registerNewUser(email, password: password)
    }
    
    @IBAction func textFieldChanged() {
        userRegister.enabled = false
        userLogIn.enabled = false
        
        guard let email = emailEntry.text else {
            return
        }
        guard let password = passwordEntry.text else {
            return
            
        }
        
        if loginManager.isValidLogin(email, password: password) {
            userRegister.enabled = true
            userLogIn.enabled = true
        }
        
    }
    
    func loginRecv() {
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    
    //MARK: - LIFE CYCLE METHODS
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldChanged()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(loginRecv), name: "LoggedInMsg", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

