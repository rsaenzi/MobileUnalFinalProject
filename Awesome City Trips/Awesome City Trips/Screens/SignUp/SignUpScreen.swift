//
//  SignUpScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 11/18/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class SignUpScreen: UIViewController {
    
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var textfieldFirstName: UITextField!
    @IBOutlet weak var textfieldLastName: UITextField!
    @IBOutlet weak var textfieldBirthday: UITextField!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    let defaultPicture = "http://profilepicturesdp.com/wp-content/uploads/2018/07/profile-picture-icon-transparent-3.png"
    
    @IBAction func onTapSignIn(_ sender: UIButton, forEvent event: UIEvent) {
        
        // Validate if all fields are valid
        guard let email = textfieldEmail.text,
            let password = textfieldPassword.text,
            let firstName = textfieldFirstName.text,
            let lastName = textfieldLastName.text,
            let birthday = textfieldBirthday.text,
            email.count > 0, password.count > 0,
            firstName.count > 0, lastName.count > 0,
            birthday.count > 0 else {
                
            self.showSimpleAlert(message: .errorLoginNoData)
            return
        }
        
        // We send the request to firebase
        KVNProgress.show()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            
            guard let `self` = self else { return }
            
            // User could not be created...
            guard let validUser = authResult?.user else {
                
                KVNProgress.dismiss()
                self.showSimpleAlert(message: .errorAtUserCreation)
                return
            }
            
            // Firebase user was created successfully at this point, now we set user info
            self.setUserInfo(user: validUser)
        }
    }
    
    @IBAction func onTapCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setUserInfo(user: Firebase.User) {
        
        // Validate if all fields are valid
        guard let email = textfieldEmail.text,
            let password = textfieldPassword.text,
            let firstName = textfieldFirstName.text,
            let lastName = textfieldLastName.text,
            let birthday = textfieldBirthday.text else {
                
            return
        }
        
        RequestSetUserInfo.request(
            token: user.uid,
            firstName: firstName,
            lastName: lastName,
            picture: self.defaultPicture,
            email: email,
            birthday: "1988-08-07T09:30:00.000Z",
            username: email,
            password: password) { [weak self] response in
                
                KVNProgress.dismiss()
                
                guard let `self` = self else { return }
                
                switch response {
                    
                case .success(let output):
                    
                    // Store the user in cache
                    Workspace.shared.currentUser = output.user
                    
                    // Now we proceed to display the main TabBar
                    let screen: MainTabBar = self.loadViewController()
                    self.present(screen, animated: true, completion: nil)
                    return
                    
                default:
                    self.showSimpleAlert(message: .errorAtLogin)
                    return
                }
        }
    }
}

