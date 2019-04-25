//
//  ProfileController.swift
//  Restaurant App
//
//  Created by sarkom3 on 22/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var logout:[String] = ["Profile", "Pesanan", "Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nama()
    }
    
    func nama(){
        Name.text = UserDefaults.standard.string(forKey: "name")
    }
}

extension ProfileController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logout.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = logout[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = logout[indexPath.row]
        
        if data == "Profile"{
            print("Ini Profile")
        }else if data == "Logout"{
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "ISUSERLOGGEDIN")
            defaults.synchronize()
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginController") as! LoginController
            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
