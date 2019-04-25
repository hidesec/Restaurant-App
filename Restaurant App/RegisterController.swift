//
//  RegisterController.swift
//  Restaurant App
//
//  Created by sarkom3 on 22/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterController: UIViewController {

    @IBOutlet weak var nameRegister: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var passwordRegister: UITextField!
    @IBOutlet weak var rePassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func register(_ sender: Any) {
        goToRegister()
    }
    @IBAction func login_(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginController") as! LoginController
        self.present(controller, animated: true, completion: nil)
    }
    
    func goToRegister(){
        if nameRegister.text?.count != 0 || emailRegister.text?.count != 0 || passwordRegister.text?.count != 0{
            if rePassword.text?.count != 0{
                if nameRegister.text?.count != 0{
                    if emailRegister.text?.count != 0 {
                        if passwordRegister.text?.count != 0 {
                            if passwordRegister.text!.count < 6 {
                                let alert = UIAlertController(title: "WARNING!", message: "Password harus lebih dari 6 karakter!", preferredStyle: .alert)
                                let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert.addAction(alertButton)
                                self.present(alert, animated: true, completion: nil)
                            }else{
                                let parameters:Parameters = ["name": nameRegister.text!,
                                                             "email": emailRegister.text!,
                                                             "password": passwordRegister.text!]
                                let url = URL(string: "http://10.10.20.29/LoginRegister/register.php")
                                //sukses
                                AF.request(url!, method: .post, parameters: parameters).responseJSON { (response) in
                                    let json = JSON(response.value!)
                                    if json["error"] == false{
                                        let alert = UIAlertController(title: "SUKSES", message: "Register Sukses", preferredStyle: .alert)
                                        let alertButton = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                                            let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginController") as! LoginController
                                            self.present(controller, animated: true, completion: nil)
                                        })
                                        alert.addAction(alertButton)
                                        self.present(alert, animated: true, completion: nil)
                                    }else{
                                        let alert = UIAlertController(title: "WARNING!", message: "Email telah digunakan!", preferredStyle: .alert)
                                        let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                                        alert.addAction(alertButton)
                                        self.present(alert, animated: true, completion: nil)
                                    }
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
                }else{
                    let alert = UIAlertController(title: "WARNING!", message: "Name Anda kosong!", preferredStyle: .alert)
                    let buttonAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(buttonAlert)
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "WARNING!", message: "Re-Password kosong!", preferredStyle: .alert)
                let buttonAlert = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(buttonAlert)
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Warning", message: "Kotak masih ada yang kosong!", preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
