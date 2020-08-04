//
//  AlertService.swift
//  ToppTurSvalbard
//
//  Created by Kjetil Dahl Knutsen on 21.06.2020.
//  Copyright © 2020 publisoft. All rights reserved.
//

import UIKit

class AlertService{
    
    func alert(title: String, message: String, completion: @escaping () -> Void) -> ImportantAlertViewController {
        
        let storyboard = UIStoryboard(name: "ImportantAlert", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertVC") as! ImportantAlertViewController
        
        alertVC.alertTitle = title
        alertVC.alertMessage = message
        
        alertVC.buttonAction = completion
        
        return alertVC
    }
    
}
