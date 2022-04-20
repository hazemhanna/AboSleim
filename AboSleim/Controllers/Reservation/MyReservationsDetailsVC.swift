//
//  MyReservationsDetailsVC.swift
//  Livia
//
//  Created by MAC on 22/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
import DropDown
import Cosmos
class MyReservationsDetailsVC   : UIViewController {
    
    @IBOutlet weak var titleLBL : UILabel!
    
    @IBOutlet weak var reservationId : UILabel!
    @IBOutlet weak var reservationType : UILabel!
    @IBOutlet weak var reservationNum : UILabel!
    @IBOutlet weak var reservationDate : UILabel!
    @IBOutlet weak var reservationNote : UILabel!

    
    var reservations:Reservations?

        
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLBL.text = "MyReservations".localized
    }

    
    override func viewWillAppear(_ animated: Bool) {
        reservationId.text = "\(reservations?.id ?? 0)"
        reservationType.text = reservations?.table?.type?.localized ?? ""
        reservationNum.text = reservations?.table?.tableNumber ?? " "
        reservationDate.text = (reservations?.reservationDate ?? "") + "  " +  (reservations?.dateFrom ?? "")
        reservationNote.text = reservations?.notes ?? ""

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
    
}
