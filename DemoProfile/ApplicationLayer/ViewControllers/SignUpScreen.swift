//
//  SignUpScreen.swift
//  DemoProfile
//
//  Created by Gaurang Lathiya on 09/12/18.
//  Copyright © 2018 Gaurang Lathiya. All rights reserved.
//

import UIKit

class SignUpScreen: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtFldFirstName: UITextField!
    @IBOutlet weak var txtFldLastName: UITextField!
    @IBOutlet weak var txtFldUserName: UITextField!
    @IBOutlet weak var txtFldAge: UITextField!
    @IBOutlet weak var txtFldEmailId: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    var strFirstName: String? = nil
    var strLastName: String? = nil
    var strUserName: String? = nil
    var strAge: String? = nil
    var strEmailId: String? = nil
    var strPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Sign Up"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    // MARK: -  UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.txtFldFirstName {
            self.strFirstName = textField.text
            return
        }
        
        if textField == self.txtFldLastName {
            self.strLastName = textField.text
            return
        }
        
        if textField == self.txtFldAge {
            self.strAge = textField.text
            return
        }
        
        if textField == self.txtFldUserName {
            self.strUserName = textField.text
            return
        }
        
        if textField == self.txtFldEmailId {
            self.strEmailId = textField.text
            return
        }
        
        if textField == self.txtFldPassword {
            self.strPassword = textField.text
            return
        }
    }

    // MARK: - Button click events
    @IBAction func btnSignUpClicked(_ sender: Any) {
        self.view.endEditing(true)
        
        guard let firstName = self.strFirstName else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter First Name..")
            }
            return
        }
        
        guard let lastName = self.strLastName else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter Last Name..")
            }
            return
        }
        
        guard let userName = self.strUserName else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter User Name..")
            }
            return
        }
        
        guard let age = self.strAge else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter Age..")
            }
            return
        }
        
        guard let emailID = self.strEmailId else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter email Id..")
            }
            return
        }
        
        guard let pass = self.strPassword else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter Password..")
            }
            return
        }
        
        print("First name: \(firstName) \t Last name: \(lastName) \t UserName: \(userName) \t age: \(age)")
        print("Email:  \(emailID) \t password: \(pass)")
        
        // we need to save data over here
        let userModel = UserCoreModel(context: CoreDataHandler.context)
        userModel.firstName = firstName
        userModel.lastName = lastName
        userModel.userName = userName
        userModel.age = Int16(age) ?? 0
        userModel.email = emailID
        userModel.password = pass
        CoreDataHandler.saveContext()
        
        // Move back to login screen
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.kApplicationName, message: "SignUp successfully", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            self.topMostViewController().present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
