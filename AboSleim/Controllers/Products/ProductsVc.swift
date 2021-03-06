//
//  BestSellerVC.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ProductsVc : UIViewController {
    
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var bestSellerTableView: UITableView!
    fileprivate let cellIdentifier = "ValiableResturantCell"
    @IBOutlet weak var emptyView: UIView!

    var productCounter = Int()

    private let homeViewModel = HomeViewModel()
    var disposeBag = DisposeBag()
    
    var products = [Product]() {
        didSet{
            DispatchQueue.main.async {
                self.bestSellerTableView.reloadData()
            }
        }
    }
    
    var catId = Int()
    var catTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bestSellerTableView.delegate = self
        bestSellerTableView.dataSource = self
        bestSellerTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        homeViewModel.showIndicator()
        self.getProduct(id : self.catId)
        self.titleLbl.text = catTitle

    }
      
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func BackBtn(_ sender: Any) {
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
extension ProductsVc: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ValiableResturantCell else {return UITableViewCell()}
    
        var price =  ""
        var image = ""

        if products[indexPath.row].variants?.count ?? 0 > 0 {
            price = products[indexPath.row].variants?[0].price ?? ""
        }
    
        if products[indexPath.row].images?.count ?? 0 > 0 {
            image = products[indexPath.row].images?[0].image ?? ""
        }
        
        if "lang".localized == "ar" {
        cell.config(name: products[indexPath.row].title?.ar ?? ""
                    , price: price
                    , imagePath:  image
                    , type: products[indexPath.row].category?.title?.ar ?? ""
                    , isWishlist: products[indexPath.row].isWishlist ?? false
                    , discount: Double(products[indexPath.row].discount ?? "") ?? 0)
        }else{
            cell.config(name: products[indexPath.row].title?.en ?? ""
                        , price:  price
                        , imagePath: image
                        ,type: products[indexPath.row].category?.title?.en ?? ""
                        ,isWishlist: products[indexPath.row].isWishlist ?? false
                        , discount: Double(products[indexPath.row].discount ?? "") ?? 0)

        }
        
        cell.goToFavorites = {
            self.homeViewModel.showIndicator()
            self.addWishList(id: self.products[indexPath.row].id ?? 0 , isWishList: self.products[indexPath.row].isWishlist ?? false)
        }
        
        cell.increase = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        cell.decrease = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        cell.addToCart = {
            guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
            details.product = self.products[indexPath.row]
            self.navigationController?.pushViewController(details, animated: true)
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let details = UIStoryboard(name: "Products", bundle: nil).instantiateViewController(withIdentifier: "ProductDetails") as? ProductDetails else { return }
        details.product = self.products[indexPath.row]
        self.navigationController?.pushViewController(details, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ProductsVc{
    
    func getProduct(id : Int) {
            self.homeViewModel.getCategoryProduct(id : id).subscribe(onNext: { (data) in
                self.homeViewModel.dismissIndicator()
                self.products = data.data?.products ?? []
                if self.products.count > 0 {
                    self.emptyView.isHidden = true
                }else{
                   self.emptyView.isHidden = false
                }
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
    }

 func addWishList(id : Int,isWishList : Bool) {
        self.homeViewModel.addWishList(id: id,isWishList :isWishList).subscribe(onNext: { (data) in
            if data.value ?? false {
                if isWishList{
                displayMessage(title: "", message: "remove to favourite".localized, status:.success, forController: self)
                }else{
                displayMessage(title: "", message: "Add to favourite".localized, status:.success, forController: self)
                }
            }

            self.getProduct(id: self.catId)
            }, onError: { (error) in
                self.homeViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
}
