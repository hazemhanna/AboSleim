//
//  FoodPackagesDetailsVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit

class FoodPackagesDetailsVC : UIViewController {
    
    @IBOutlet weak var oneImageView: UIImageView!
    @IBOutlet weak var mealNameLB: UILabel!
    @IBOutlet weak var discribtionLbl : UILabel!
    @IBOutlet weak var periodLbl : UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var subprice: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var devliveryTitle: UILabel!
    
    @IBOutlet weak var yesLBL : UILabel!
    @IBOutlet weak var noLBL : UILabel!
    
    @IBOutlet weak var yesBtN : UIButton!
    @IBOutlet weak var noBtN : UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if "lang".localized == "en" {
            mealNameLB.textAlignment = .left
            discribtionLbl.textAlignment = .left
            periodLbl.textAlignment = .left
            price.textAlignment = .left
            subprice.textAlignment = .left
            subTitle.textAlignment = .left
            devliveryTitle.textAlignment = .left
            yesLBL.textAlignment = .left
            noLBL.textAlignment = .left
        }else{
            mealNameLB.textAlignment = .right
            discribtionLbl.textAlignment = .right
            periodLbl.textAlignment = .right
            price.textAlignment = .right
            subprice.textAlignment = .right
            subTitle.textAlignment = .right
            devliveryTitle.textAlignment = .right
            yesLBL.textAlignment = .right
            noLBL.textAlignment = .right
        }
        
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
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
    
    @IBAction func confirm(_ sender: UIButton) {
        displayMessage(title: "", message: "تم الاضافة الي السلة بنجاح".localized, status:.success, forController: self)
    }
    
    @IBAction func yesBtn(_ sender: UIButton) {
       if sender.tag == 0 {
           yesBtN.setImage(#imageLiteral(resourceName: "select"), for: .normal)
           noBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }else{
            noBtN.setImage(#imageLiteral(resourceName: "select"), for: .normal)
            yesBtN.setImage(#imageLiteral(resourceName: "check"), for: .normal)
        }
    }
    
    
}

