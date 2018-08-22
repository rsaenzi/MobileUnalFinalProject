//
//  UIApplication+TopController.swift
//
//  Created by Rigoberto Sáenz Imbacuán (https://www.linkedin.com/in/rsaenzi/)
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var topViewController: UIViewController? {
        
        if keyWindow?.rootViewController == nil {
            return keyWindow?.rootViewController
        }
        
        var pointedViewController = keyWindow?.rootViewController
        
        while  pointedViewController?.presentedViewController != nil {
            
            switch pointedViewController?.presentedViewController {
                
            case let navagationController as UINavigationController:
                pointedViewController = navagationController.viewControllers.last
                
            case let tabBarController as UITabBarController:
                pointedViewController = tabBarController.selectedViewController
                
            default:
                pointedViewController = pointedViewController?.presentedViewController
            }
        }
        return pointedViewController
    }
}
