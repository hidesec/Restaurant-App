//
//  ViewController.swift
//  Restaurant App
//
//  Created by sarkom3 on 19/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleHome: UILabel!
    @IBOutlet weak var locationHome: UIImageView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var descriptionHome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Enak Restaurant"
        homeView()
        // Do any additional setup after loading the view.
    }
    
    func homeView(){
        self.image.image = UIImage(named: "home_image")
        self.titleHome.text = "Enak Restaurant"
        self.locationHome.image = UIImage(named: "location")
        self.labelLocation.text = "Jakarta"
        self.descriptionHome.text = "Back from the beach, a bike ride in our beautiful surroundings or from a shopping session you would definitely enjoy to relax at the table and taste a good wine and great food. \n\nThe imagination of our chefs will never bore you with always different and delicious dishes. \n\nThe attention in choice of genuine and local ingredients will relax you. \n\nThe accurate service, the elegance of our dining halls will make you feel at ease. \n\nThe availability of our friendly staff will pamper you. \n\nYou will always have a wide choice of vegetables on the buffet to be seasoned with oil of our land. You can always choose meat or fish courses or one of ours delicious dishes, a soup or a cold dish."
    }


}

