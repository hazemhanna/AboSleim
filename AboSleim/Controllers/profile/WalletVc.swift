//
//  WalletVc.swift
//  Shanab
//
//  Created by MAC on 09/10/2021.
//  Copyright © 2021 Dtag. All rights reserved.
//


import UIKit
import DropDown

class WalletVc: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var orderbtn : UIButton!
    @IBOutlet weak var rewardsBtn : UIButton!
    @IBOutlet weak var titleLbl  : UILabel!
    fileprivate let cellIdentifier = "RefundOrderCell"
    fileprivate let cellIdentifier2 = "RewardCell"

    var type = "order"
    var totalWallet = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderbtn.setTitle("refund".localized, for: .normal)
        rewardsBtn.setTitle("rewards".localized, for: .normal)
       // titleLbl.text = "".localized
        titleLbl.text = "wallet".localized

    }
    
    override func viewWillAppear(_ animated: Bool) {
            listTableView.delegate = self
            listTableView.dataSource = self
            listTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
            listTableView.register(UINib(nibName: cellIdentifier2, bundle: nil), forCellReuseIdentifier: cellIdentifier2)
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func rewardBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            self.orderbtn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1725490196, blue: 0.2431372549, alpha: 1)
            self.rewardsBtn.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9725490196, blue: 0.8901960784, alpha: 1)
            self.type = "order"
            self.orderbtn.setTitleColor(UIColor.white, for: .normal)
            self.rewardsBtn.setTitleColor(UIColor.black, for: .normal)
            self.listTableView.reloadData()
        }else{
            self.orderbtn.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9725490196, blue: 0.8901960784, alpha: 1)
            self.rewardsBtn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1725490196, blue: 0.2431372549, alpha: 1)
            self.type = "reward"
            self.orderbtn.setTitleColor(UIColor.black, for: .normal)
            self.rewardsBtn.setTitleColor(UIColor.white, for: .normal)
            self.listTableView.reloadData()
        }
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeProfileAction(_ sender: UIButton) {
            guard let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ChangeProfileVC") as? ChangeProfileVC else {return}
            self.navigationController?.pushViewController(sb, animated: true)
        
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
extension WalletVc: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "order"{
         return 4
        }else{
         return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == "order"{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RefundOrderCell else { return UITableViewCell()}
            cell.goToDetails = {
                guard let Details = UIStoryboard(name: "Orders", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC else { return }
                self.navigationController?.pushViewController(Details, animated: true)
            }
        return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier2, for: indexPath) as? RewardCell else { return UITableViewCell()}
            return cell
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "order"{
            guard let Details = UIStoryboard(name: "Details", bundle: nil).instantiateViewController(withIdentifier: "UserOrderDetailsVC") as? UserOrderDetailsVC else { return }
            self.navigationController?.pushViewController(Details, animated: true)
        }
    }
    
}
