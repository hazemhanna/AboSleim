//
//  RewardCell.swift
//  Shanab
//
//  Created by MAC on 10/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//

import UIKit

class RewardCell: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var valueLble : UILabel!
    @IBOutlet weak var dateLble : UILabel!
    @IBOutlet weak var paidLble : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func config( date: String, title: String, value: Int,totalWallet : Int) {
        self.dateLble.text = "date".localized + " " + date
        self.titleLbl.text = title
        self.valueLble.text = "\(value)" + " " + "SAR".localized
        if totalWallet != 0 {
            self.paidLble.isHidden = true
        }else{
            self.paidLble.isHidden = false
        }
        
    }
}
