//
//  UIViewController+Alert.swift
//
//  Created by Rigoberto Sáenz Imbacuán (https://www.linkedin.com/in/rsaenzi/)
//  Copyright © 2017. All rights reserved.
//

import UIKit

typealias AlertInfo = (title: LanguageKey, message: LanguageKey)

extension UIViewController {
    
    func showSimpleAlert(info: AlertInfo, onClose completion: ((UIAlertAction) -> Void)? = nil) {
        self.showSimpleAlert(title: info.title, message: info.message, onClose: completion)
    }
    
    func showSimpleAlert(title: LanguageKey = .appName, message: LanguageKey,
                         onClose completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message)
        let action = UIAlertAction(title: .okUpper, handler: completion)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
