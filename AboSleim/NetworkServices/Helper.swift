//
//  Helper.swift
//  Shanab
//
//  Created by Macbook on 3/24/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import MOLH
class Helper {
    class func restartApp() {
        guard let window = UIApplication.shared.keyWindow else { return }
        var vc = UIViewController()
        if let api_token = Helper.getApiToken() {
            print("api_token: \(api_token)")
            switch Helper.getUserRole() {
            case "customer":
                print("true")
                    
            default:
                break
                
            }
        } else {
            vc = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar")
            Singletone.instance.appUserType = .Customer
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: nil, completion: nil)
        }
    }
    
    class func saveApiToken(token: String, email: String, user_id: Int) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "api_token")
        def.set(user_id, forKey: "user_id")
        def.set(email, forKey: "email")
        restartApp()
    }
    
    class func saveToken(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "api_token")
    }
    
    class func getApiToken() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "api_token") as? String
        
    }
    class func saveUserRole(role: String) {
        let def = UserDefaults.standard
        def.setValue(role, forKey: "role")
    }
    class func getUserRole() -> String? {
        let def = UserDefaults.standard
        return  def.object(forKey: "role") as? String
    }
    
    class func LogOutUser() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "api_token")
        def.removeObject(forKey: "role")
        def.removeObject(forKey: "user_id")
        def.removeObject(forKey: "email")
    }
  
    class func getemail() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "email") as? String
    }
    
    class func savedate(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "date")
        def.synchronize()
    }
    class func getdate() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "date") as? String
    }
    
    class func savetime(token: String) {
        let def = UserDefaults.standard
        def.set(token, forKey: "time")
        def.synchronize()
    }

    class func getTime() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "time") as? String
    }
    
}





