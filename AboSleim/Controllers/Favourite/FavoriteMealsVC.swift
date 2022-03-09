//
//  FavoriteMealsVC.swift
//  Shanab
//
//  Created by Macbook on 7/1/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit

class FavoriteMealsVC: UIViewController {
    @IBOutlet weak var titleLbl  : UILabel!

    @IBOutlet weak var favoriteMealsTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var noProduct: UILabel!
    
    fileprivate let cellIdentifier = "ValiableResturantCell"

    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.favoriteMealsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMealsTableView.delegate = self
        favoriteMealsTableView.dataSource = self
        favoriteMealsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        titleLbl.text =  "Favorite Meals".localized
    
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كفتة ضاني", image: #imageLiteral(resourceName: "image3"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع مشكل", image: #imageLiteral(resourceName: "image4"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "نص ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: Any) {
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "ScanVc") as? ScanVc else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    
    func show () {
        if meals.count > 0 {
            favoriteMealsTableView.isHidden = false
            self.emptyView.isHidden = true
        }else{
            favoriteMealsTableView.isHidden = true
            self.emptyView.isHidden = false
        }
    }
    
}

extension FavoriteMealsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        cell.config(name: meals[indexPath.row].nameAr ?? "",price: 12.2, imagePath: meals[indexPath.row].image  , type: meals[indexPath.row].descriptionAr ?? "")

         cell.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
        
        cell.goToFavorites = {
            self.meals.remove(at: indexPath.row)
            self.show()
         }
        
        cell.increase = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.meals = self.meals[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        cell.decrease = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.meals = self.meals[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
            
        }
        
        
        cell.addToCart = {
            displayMessage(title: "", message: "تم الاضافة الي السلة بنجاح".localized, status:.success, forController: self)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        details.meals = self.meals[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}