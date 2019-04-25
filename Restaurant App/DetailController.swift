//
//  DetailController.swift
//  Restaurant App
//
//  Created by sarkom3 on 19/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var arrayMakanan:[ListMakanan] = []
    
    @IBOutlet weak var imageController: UIImageView!
    @IBOutlet weak var titleMakananController: UILabel!
    @IBOutlet weak var hargaController: UILabel!
    @IBOutlet weak var resepController: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        for makanan in arrayMakanan {
            self.imageController.loadImageUsingCacheWithUrl("http://10.10.20.29/Restaurant/images/" + makanan.imagesMakanan!)
            self.titleMakananController.text = makanan.titleMakanan
            self.hargaController.text = "Rp. \(makanan.hargaMakanan!)"
            self.resepController.text = makanan.bahanMakanan
            self.navigationItem.title = makanan.titleMakanan
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
}
