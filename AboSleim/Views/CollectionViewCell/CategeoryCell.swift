//
//  CategeoryCell.swift
//  AboSleim
//
//  Created by MAC on 10/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit
import UIKit

class CategeoryCell: UICollectionViewCell {
    @IBOutlet weak var sectionName: UILabel!
    @IBOutlet weak var sectionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sectionName.adjustsFontSizeToFitWidth = true
        self.sectionName.minimumScaleFactor = 0.5
    }
    func config( imagePath: UIImage , name: String){

        //if imagePath != "" {
        //  guard let imageURL = URL(string: imagePath) else { return }
        self.sectionImage.image = imagePath //.kf.setImage(with: imageURL)
         // }
        
        self.sectionName.text = name
       }

}
