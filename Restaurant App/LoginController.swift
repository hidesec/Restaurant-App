//
//  LoginController.swift
//  Restaurant App
//
//  Created by sarkom3 on 22/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginController: UIViewController {

    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func Login(_ sender: Any) {
        goToLogin()
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "registerController") as! RegisterController
        self.present(controller, animated: true, completion: nil)
    }
    
    func goToLogin(){
        if emailLogin.text?.count != 0 {
            if passwordLogin.text?.count != 0 {
                
                let parameters:Parameters = ["email": emailLogin.text!,
                                             "password": passwordLogin.text!]
                let url = URL(string: "http://10.10.20.29/LoginRegister/login.php")
                //sukses
                AF.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
                    let json = JSON(response.value!)
                    if json["error"] == false {
                        let controller = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                        self.present(controller, animated: true, completion: nil)
                        
                        //session
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "ISUSERLOGGEDIN")
                        defaults.synchronize()
                        defaults.set(json["user"]["name"].stringValue, forKey: "name")
                        
                    } else{
                        let alert = UIAlertController(title: "WARNING!", message: "Email atau password yang Anda masukkan salah!", preferredStyle: .alert)
                        let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(alertButton)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }else{
                let alert = UIAlertController(title: "WARNING!", message: "Password Anda kosong!", preferredStyle: .alert)
                let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertButton)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "WARNING!", message: "Email Anda kosong!", preferredStyle: .alert)
            let buttonAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(buttonAlert)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

