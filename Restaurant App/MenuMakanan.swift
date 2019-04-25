//
//  SearchController.swift
//  Restaurant App
//
//  Created by sarkom3 on 19/04/19.
//  Copyright © 2019 sarkom3. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MenuMakanan: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayMakanan:[ListMakanan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Daftar Makanan"
        request()
        collectionView.delegate = self
        collectionView.dataSource = self
        //Register NIB File
        collectionView.register(UINib(nibName: "CustomCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let controller = segue.destination as! DetailController
            let indexPath = collectionView.indexPathsForSelectedItems?.first?.item
            controller.arrayMakanan = [arrayMakanan[indexPath!]]
        }
    }
    func request(){
        if let url = URL(string: "http://10.10.20.29/Restaurant/data.php"){
            AF.request(url).responseJSON { (response) in
                let json = JSON(response.value!)["data"].arrayValue
                for makanan in json{
                    let images = makanan["imagesMakanan"].stringValue
                    let namaMakanan = makanan["titleMakanan"].stringValue
                    let hargaMakanan = makanan["hargaMakanan"].stringValue
                    let bahanMakanan = makanan["bahanMakanan"].stringValue
                    let data = ListMakanan(imagesMakanan: images, titleMakanan: namaMakanan, hargaMakanan: hargaMakanan, bahanMakanan: bahanMakanan)
                    self.arrayMakanan.append(data)
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension MenuMakanan: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayMakanan.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        let dataMakanan = arrayMakanan[indexPath.row]
        cell.imageCell.loadImageUsingCacheWithUrl("http://10.10.20.29/Restaurant/images/" + dataMakanan.imagesMakanan!)
        cell.titleMakananCell.text = dataMakanan.titleMakanan
        cell.hargaCell.text = "Rp.  \(dataMakanan.hargaMakanan!)"
        
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{
    
    func loadImageUsingCacheWithUrl(_ urlString: String){
        self.image = nil
        
        //check cache with image firts
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadImage = UIImage(data: data!){
                    imageCache.setObject(downloadImage, forKey: urlString as AnyObject)
                    self.image = downloadImage
                }
            })
        }.resume()
    }
}
