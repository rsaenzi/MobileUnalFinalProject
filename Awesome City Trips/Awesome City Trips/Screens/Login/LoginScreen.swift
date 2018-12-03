//
//  LoginScreen.swift
//  Awesome City Trips
//
//  Created by Rigoberto Sáenz Imbacuán on 11/18/18.
//  Copyright © 2018 Awesome City Team. All rights reserved.
//

import UIKit
import Firebase
import KVNProgress

class LoginScreen: UIViewController {
    
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var textfieldPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonSignIn: UIButton!
    
    @IBAction func onTapLogin(_ sender: UIButton, forEvent event: UIEvent) {
        
        // Validate if all fields are valid
        guard let email = textfieldEmail.text,
              let password = textfieldPassword.text,
              email.count > 0, password.count > 0 else {
                
            self.showSimpleAlert(message: .errorLoginNoData)
            return
        }
        
        // We send the request to firebase
        KVNProgress.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            
            guard let `self` = self else { return }
            
            // Unsuccessful login...
            guard let validUser = user else {
                
                KVNProgress.dismiss()
                self.showSimpleAlert(message: .errorAtLogin)
                return
            }
            
            // Now we fetch user info
            self.getUserInfo(user: validUser)
        }
    }
    
    private func getUserInfo(user: AuthDataResult) {
     
        RequestGetUserInfo.request(userId: user.user.uid) { [weak self] response in
            
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
