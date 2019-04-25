//
//  CollectionViewController.swift
//  Restaurant App
//
//  Created by sarkom3 on 22/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var arrayCollection:[Listing] = {
       //
        let Index = Listing(images: UIImage(named: "shop"), title: "Selamat Datang di Enak Restaurant!")
        let Index2 = Listing(images: UIImage(named: "alatmakan"), title: "Do You Have Account? Register Now!")
        let Index3 = Listing(images: UIImage(named: "go-to-shop"), title: "Let's Go!")
        return [Index, Index2, Index3]
    }()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        pageController.numberOfPages = arrayCollection.count
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CustomCell2", bundle: nil), forCellWithReuseIdentifier: "CustomCell2")
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        
        pageController.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    @objc func Login(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginController") as! LoginController
        self.present(controller, animated: true, completion: nil)
    }
    @objc func Register(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "registerController") as! RegisterController
        self.present(controller, animated: true, completion: nil)
        
    }
    @objc func Go(){
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "registerController") as! RegisterController
        self.present(controller, animated: true, completion: nil)
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell2", for: indexPath) as! CustomCell2
        let data = arrayCollection[indexPath.row]
        cell.imagesCell.image = data.images
        cell.titleCell.text = data.title
        
        if data.title == "Selamat Datang di Enak Restaurant!"{
            cell.buttonCell.isHidden = false
            cell.buttonCell.setTitle("Login", for: .normal)
            cell.buttonCell.addTarget(self, action: #selector(Login), for: .touchUpInside)
        } else if data.title == "Do You Have Account? Register Now!"{
            cell.buttonCell.isHidden = false
            cell.buttonCell.setTitle("Register", for: .normal)
            cell.buttonCell.addTarget(self, action: #selector(Register), for: .touchUpInside)
        }else if data.title == "Let's Go!"{
            cell.buttonCell.isHidden = false
            cell.buttonCell.setTitle("GO!", for: .normal)
            cell.buttonCell.addTarget(self, action: #selector(Go), for: .touchUpInside)
        }else{
            cell.buttonCell.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
