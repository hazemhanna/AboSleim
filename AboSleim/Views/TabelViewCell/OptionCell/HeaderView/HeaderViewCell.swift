//
//  HeaderViewCell.swift
//  Livia
//
//  Created by MAC on 28/03/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
