//
//  MainProfileVC.swift
//  Livia
//
//  Created by MAC on 27/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//



import UIKit

class MainProfileVC : UIViewController {

    @IBOutlet weak var titleLbl  : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLbl.text = "Profile".localized

    }
    
    @IBAction func popUpAction(_ sender: UIButton) {
        
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






