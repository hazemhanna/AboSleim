//
//  FiltterResaultVC.swift
//  Livia
//
//  Created by MAC on 01/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit

class FiltterResaultVC: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var empyView : UIView!
    @IBOutlet weak var titleLbl  : UILabel!

    
    private let cellIdentifier = "ValiableResturantCell"

    var meals = [RestaurantMeal]() {
        didSet{
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "fillter".localized

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.tableFooterView = UIView()
        searchTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.navigationController?.navigationBar.isHidden = true
        meals.append(RestaurantMeal(nameAr: "ربع ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كفتة ضاني", image: #imageLiteral(resourceName: "image3"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع مشكل", image: #imageLiteral(resourceName: "image4"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "كيلو كفتة ضاني", image: #imageLiteral(resourceName: "image6"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "نص ريش ضاني", image: #imageLiteral(resourceName: "image1"), descriptionAr: "مشويات"))
        meals.append(RestaurantMeal(nameAr: "ربع كباب ضاني", image: #imageLiteral(resourceName: "image2"), descriptionAr: "مشويات"))
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
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
extension FiltterResaultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
        
        cell.config(name: meals[indexPath.row].nameAr ?? "",price: 12.2, imagePath: meals[indexPath.row].image  , type: meals[indexPath.row].descriptionAr ?? "")

        
        cell.goToFavorites = {
            if cell.isFavourite{
                cell.FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
                displayMessage(title: "", message: "تم المسح من المفضلة بنجاح".localized, status:.success, forController: self)

                cell.isFavourite = false
            }else{
                cell.FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                cell.isFavourite = true
                displayMessage(title: "", message: "تم الاضافة الي المفضلة بنجاح".localized, status:.success, forController: self)

            }
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

