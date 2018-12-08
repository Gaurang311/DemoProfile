//
//  LoginScreen.swift
//  DemoProfile
//
//  Created by Gaurang Lathiya on 09/12/18.
//  Copyright © 2018 Gaurang Lathiya. All rights reserved.
//

import UIKit
import CoreData

class LoginScreen: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var txtFldEmailId: UITextField!
    @IBOutlet weak var txtFldPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var strEmailId: String? = nil
    var strPassword: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setAppThemeGreenNavigationBar()
        self.enableSwipeLeftToBack()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Login"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    @IBAction func btnLoginTapped(_ sender: Any) {
        self.view.endEditing(true)
        guard let emailID = self.strEmailId, let pass = self.strPassword else {
            DispatchQueue.main.async {
                self.showAlert(withTitle: Constants.kApplicationName, message: "Please enter credentials..")
            }
            return
        }
        print("Email:  \(emailID) \t password: \(pass)")
        // we need to compare data over here
        
        let fetchRequest: NSFetchRequest<UserCoreModel> = UserCoreModel.fetchRequest()
        let p1 = NSPredicate(format: "email = %@", emailID)
        let p2 = NSPredicate(format: "password = %@", pass)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [p1, p2])
        
        fetchRequest.predicate = predicate //NSPredicate(format: "email == \(emailID) && password == \(pass)")
        do {
            let users = try CoreDataHandler.context.fetch(fetchRequest)
            if let userObj = users.first {
                DispatchQueue.main.async {
                    self.showAlert(withTitle: Constants.kApplicationName, message: userObj.profileData())
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(withTitle: Constants.kApplicationName, message: "Your credential is invalid..")
                }
            }
        } catch let error {
            print("Data fetch error: \(error.localizedDescription)")
        }
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        if let signUpScreenObj: SignUpScreen = self.storyboard?
            .instantiateViewController(withIdentifier: String(describing: SignUpScreen.self)) as? SignUpScreen  {
            self.navigationController?.pushViewController(signUpScreenObj, animated: true)
        }
    }
}
