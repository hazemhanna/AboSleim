//
//  HomeCell.swift
//  Shanab
//
//  Created by Macbook on 4/14/20.
//  Copyright © 2020 Dtag. All rights reserved.
//




import UIKit
import Kingfisher
import Cosmos
class HomeCell: UICollectionViewCell {

    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var FavoriteBN: UIButton!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantityTF: UILabel!
    
    var isFavourite = Bool()
    var goToFavorites: (() ->Void)? = nil
    
    var increase: (() ->Void)? = nil
    var decrease: (() ->Void)? = nil
    var addToCart: (() ->Void)? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        resturantImage.setRounded()
    }
    
      func config(name: String,price: Double, imagePath: UIImage, type: String) {

          //if imagePath != "" {
          //  guard let imageURL = URL(string: imagePath) else { return }
        self.resturantImage.image = imagePath //.kf.setImage(with: imageURL)
           // }

        self.name.text = name
        self.type.text = type

        if "lang".localized == "ar" {
            self.price.text = "السعر :\(price) جنية"
        } else {
            self.price.text = " price :\(price) EGP"
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
