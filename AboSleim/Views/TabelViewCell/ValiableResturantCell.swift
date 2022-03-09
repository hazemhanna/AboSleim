//
//  ValiableResturantCell.swift
//  Shanab
//
//  Created by Macbook on 3/23/20.
//  Copyright © 2020 Dtag. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos
class ValiableResturantCell: UITableViewCell {
   
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantityTF: UILabel!
    @IBOutlet weak var cartBtn: UIButton!

    @IBOutlet weak var contentStackView: UIStackView!

    var isFavourite = Bool()
    var goToFavorites: (() ->Void)? = nil
    var addToCart: (() ->Void)? = nil
    var increase: (() ->Void)? = nil
    var decrease: (() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        if "lang".localized == "ar" {
            name.textAlignment = .left
            type.textAlignment = .left
        }else{
            name.textAlignment = .right
            type.textAlignment = .right
        }
    }
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func config(name: String,price: Double, imagePath: UIImage, type: String) {

          //if imagePath != "" {
          //  guard let imageURL = URL(string: imagePath) else { return }
        self.resturantImage.image = imagePath //.kf.setImage(with: imageURL)
           // }

        self.name.text = name
        self.type.text = type

        if "lang".localized == "ar" {
            self.price.text = "\(price) جنية"
            self.name.textAlignment = .right
            self.type.textAlignment = .right
        } else {
            self.price.text = "\(price) EGP"
            self.name.textAlignment = .left
            self.type.textAlignment = .left
        }
    }
    
    @IBAction func AddToFavorite(_ sender: Any) {
        goToFavorites?()
    }
    
    
    @IBAction func Increase(_ sender: UIButton) {
        increase?()
    }

    @IBAction func decreaseBN(_ sender: UIButton) {
        decrease?()
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        addToCart?()
    }
    
    
}
