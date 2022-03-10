//
//  HomeViewController.swift
//  Livia
//
//  Created by MAC on 11/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit
import ImageSlideshow
import DropDown
import SwiftMessages
import Alamofire

class HomeViewController: UIViewController {

    @IBOutlet weak var RestaurantTableView: UITableView!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var homeSectionsCollectionView: UICollectionView!
    @IBOutlet weak var notificationBN: UIButton!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var SlidercollectionView: UICollectionView!
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var mealsCollectionView: UICollectionView!

    
    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.mealsCollectionView.reloadData()
            }
        }
    }
    
    var timer = Timer()
    var counter = 0
    
    
    fileprivate let CellIdentifierCollectionView = "SectionCell"
    fileprivate let homeCell = "HomeCell"
    fileprivate let sliderCell = "SliderCell"
    
    var productCounter = Int()
     var imgArr = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = false
        homeSectionsCollectionView.delegate = self
        homeSectionsCollectionView.dataSource = self
        homeSectionsCollectionView.register(UINib(nibName: CellIdentifierCollectionView, bundle: nil), forCellWithReuseIdentifier: CellIdentifierCollectionView)

        SlidercollectionView.delegate = self
        SlidercollectionView.dataSource = self
        SlidercollectionView.register(UINib(nibName: sliderCell, bundle: nil), forCellWithReuseIdentifier: sliderCell)

        
        titleLbl.text = "Home".localized
        
        mealsCollectionView.delegate = self
        mealsCollectionView.dataSource = self
        mealsCollectionView.register(UINib(nibName: homeCell, bundle: nil), forCellWithReuseIdentifier: homeCell)

//        if (Helper.getApiToken() ?? "") != "" {
//          notificationBN.isHidden = false
//        }else{
//            notificationBN.isHidden = true
//        }
        
        imgArr.append(#imageLiteral(resourceName: "image1"))
        imgArr.append(#imageLiteral(resourceName: "image2"))
        imgArr.append(#imageLiteral(resourceName: "image3"))
        imgArr.append(#imageLiteral(resourceName: "image4"))
        imgArr.append(#imageLiteral(resourceName: "image5"))
        imgArr.append(#imageLiteral(resourceName: "image6"))
        
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كفتة ضاني", image: #imageLiteral(resourceName: "image3"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع مشكل", image: #imageLiteral(resourceName: "image4"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "نص ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))

        meals.append(RestaurantMeal(nameAr: "ربع مشكل", image: #imageLiteral(resourceName: "image5"), descriptionAr: "مشويات"))
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        
        DispatchQueue.main.async {
              self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
           }
    }
    
    @objc func changeImage() {
             
         if counter < imgArr.count {
              let index = IndexPath.init(item: counter, section: 0)
              self.SlidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageView.currentPage = counter
              counter += 1
         } else {
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.SlidercollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
               pageView.currentPage = counter
               counter = 1
           }
      }
    
    

    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }


    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }

    fileprivate func setupImageSlider() {

    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == SlidercollectionView {
            return imgArr.count
        }else if collectionView == mealsCollectionView{
            return meals.count
        }else {
            return 6
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == SlidercollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sliderCell, for: indexPath) as? SliderCell else { return UICollectionViewCell()}
            cell.cellImage.image = self.imgArr[indexPath.row]
            return cell
            
        }else if collectionView == mealsCollectionView{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCell, for: indexPath) as? HomeCell else { return UICollectionViewCell()}
            
            cell.config(name: meals[indexPath.row].nameAr, price: 49, imagePath: meals[indexPath.row].image, type: meals[indexPath.row].descriptionAr)
        return cell
        }else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifierCollectionView, for: indexPath) as? SectionCell else { return UICollectionViewCell()}
            
            return cell
            }

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeSectionsCollectionView {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductsVc") as? ProductsVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    
        }else if collectionView == mealsCollectionView {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        details.meals = self.meals[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
            }
        
    }
    
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == SlidercollectionView {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)

        }else if collectionView == mealsCollectionView{
        
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space) / 2.1
            return CGSize(width: size  , height: 250 )
            
        }else{
            let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
            let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
            let size: CGFloat = (collectionView.frame.size.width - space) / 4.1
            return CGSize(width: size, height: collectionView.frame.size.height)
        }
    }
}

struct RestaurantMeal {
    var nameAr : String!
    var image : UIImage!
    var descriptionAr : String!

}
