//
//  MakeOrderVC.swift
//  Shanab
//
//  Created by Macbook on 3/26/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import DLRadioButton

class ProductDetails: UIViewController {
    
    @IBOutlet weak var quantityTF: UILabel!
    @IBOutlet weak var stackViewST: UIStackView!
    @IBOutlet weak var mealNameLB: UILabel!
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discribtionLbl : UILabel!
    @IBOutlet weak var typeLbl : UILabel!
    @IBOutlet weak var FavoriteBN : UIButton!

    var isFavourite = Bool()
    var meals : RestaurantMeal?
    fileprivate let cellIdentifier = "AdditionsCell"
    fileprivate let HeaderIdentifier = "HeaderCell"
    var restaurant_id = Int()
    var productCounter = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealNameLB.text = meals?.nameAr
       // RestaurantName.text = meals?.descriptionAr
        oneImageView.image = meals?.image
        if "lang".localized == "en" {
            price.textAlignment = .left
            discribtionLbl.textAlignment = .left
            typeLbl.textAlignment = .left
            mealNameLB.textAlignment = .left
        }else{
            price.textAlignment = .right
            discribtionLbl.textAlignment = .right
            typeLbl.textAlignment = .right
            mealNameLB.textAlignment = .right
        }
    }
    
    
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cart(_ sender: Any) {
        setupSideMenu()
    }
    
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
    
    @IBAction func Increase(_ sender: UIButton) {
        self.productCounter += 1
        self.quantityTF.text = "\(self.productCounter)"
    }

    @IBAction func decreaseBN(_ sender: UIButton) {
        if productCounter > 1 {
            self.productCounter -= 1
            self.quantityTF.text = "\(self.productCounter)"
        }
    }
    


    @IBAction func confirm(_ sender: UIButton) {
        
//        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
//
//            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
//        } else {
//
//
//        }
        displayMessage(title: "", message: "تم الاضافة الي السلة بنجاح".localized, status:.success, forController: self)
    }
    
    
    @IBAction func favourit(_ sender: UIButton) {
        
//        if Helper.getApiToken() == "" || Helper.getApiToken() == nil {
//            displayMessage(title: "", message: "You should login first".localized, status:.warning, forController: self)
//        } else {
        

            if isFavourite{
                FavoriteBN.setImage(UIImage(named: "heart"), for: .normal)
                isFavourite = false
                displayMessage(title: "", message: "تم المسح من المفضلة بنجاح".localized, status:.success, forController: self)

            }else{
                FavoriteBN.setImage(UIImage(named: "222"), for: .normal)
                isFavourite = true
                displayMessage(title: "", message: "تم الاضافة الي المفضلة بنجاح".localized, status:.success, forController: self)

            }
            
        //}
    }
    
}
