//
//  SectionsVC.swift
//  Shanab
//
//  Created by Macbook on 3/25/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class SectionsVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    @IBOutlet weak var sectionCollectionView: UICollectionView!
    fileprivate let cellIdentifier = "CategeoryCell"

    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.sectionCollectionView.reloadData()
            }
        }
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionCollectionView.delegate = self
        sectionCollectionView.dataSource = self
        sectionCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        titleLbl.text = "Sections".localized
    
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "نص ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
      
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))
  //      meals.append(RestaurantMeal(nameAr: "ربع كفتة ضاني", image: #imageLiteral(resourceName: "image3"), descriptionAr: "مشويات"))
//       meals.append(RestaurantMeal(nameAr: "ربع مشكل ضاني", image: #imageLiteral(resourceName: "image4"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))

    }
    

    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
}


extension SectionsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CategeoryCell else { return UICollectionViewCell()}
        cell.config(imagePath: meals[indexPath.row].image, name: meals[indexPath.row].descriptionAr ?? "")
        return cell

        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVc") as? ProductsVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}
extension SectionsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.1
        return CGSize(width: size  , height: 150 )
    }
    
}
