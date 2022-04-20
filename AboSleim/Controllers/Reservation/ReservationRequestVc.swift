//
//  ReservationRequestVc.swift
//  Livia
//
//  Created by MAC on 19/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import Foundation
import UIKit
import ImageSlideshow
import RxSwift
import RxCocoa


class ReservationRequestVc : UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var familyImage : UIImageView!
    @IBOutlet weak var personImageImage : UIImageView!
    @IBOutlet weak var selectCateDropDown: TextFieldDropDown!    
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!

    private let reservationVM  = ReservatiomViewModel()
    var disposeBag = DisposeBag()
    
    var type = "inside"
    var number = ""

    var numbers = ["1","2","3","4","5","6","7","8","9","10+"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCatDropDown()
        titleLbl.text = "Reserve Table".localized
        selectCateDropDown.text  = "People Number".localized
        
        if "lang".localized == "ar" {
            noteTF.textAlignment = .right
            dateTF.textAlignment = .right
            selectCateDropDown.textAlignment = .right

        }else{
            noteTF.textAlignment = .left
            dateTF.textAlignment = .left
            selectCateDropDown.textAlignment = .left
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateTF.text = (Helper.getdate() ?? "") + "    " +  (Helper.getTime() ?? "")
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func scanhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }
    
    @IBAction func rewardBtn(_ sender: UIButton) {
        if sender.tag == 0 {
            familyImage.image = UIImage(named: "family2")
            personImageImage.image = UIImage(named: "family")
        type = "inside"

        }else {
            familyImage.image = UIImage(named: "family")
            personImageImage.image = UIImage(named: "family2")
            type = "outside"

        }
    }
    
    func setupCatDropDown(){
        selectCateDropDown.optionArray = self.numbers
        selectCateDropDown.didSelect { (selectedText, index, id) in
            self.number = selectedText
            if index == 9 {
                displayMessage(title: "", message: "اكتب عدد الاشخاص".localized, status:.info, forController: self)
                self.selectCateDropDown.becomeFirstResponder()
            }else{
                self.selectCateDropDown.text = selectedText
            }
        }
    }

    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        let main = UIStoryboard(name: "Reservation", bundle: nil).instantiateViewController(withIdentifier: "OrderDateVC")
        self.navigationController?.pushViewController(main, animated: true)
    }

    
    
    @IBAction func confirm(_ sender: UIButton) {
        
        if self.number == "" {
            displayMessage(title: "", message: "Select the number of people".localized, status:.error, forController: self)
        }else{
        self.reservationVM.showIndicator()
        createReservatiom(table_number: self.selectCateDropDown.text ?? "", reservation_date: Helper.getdate() ?? "" , notes: self.noteTF.text ?? "" , type: self.type, time_from:  Helper.getTime() ?? "")
      }
    }
    
}

extension ReservationRequestVc{

    func createReservatiom(table_number : String,reservation_date : String,notes : String,type:String,time_from : String) {
            self.reservationVM.createReservatiom(table_number: table_number, reservation_date: reservation_date, notes: notes, type: type, time_from: time_from).subscribe(onNext: { (data) in
                 self.reservationVM.dismissIndicator()
                
                if data.value ?? false {
                displayMessage(title: "", message: "resdone".localized, status:.success, forController: self)
                guard let window = UIApplication.shared.keyWindow else { return }
                    let sb = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabBar") as! UITabBarController
                    sb.selectedIndex = 0
                    window.rootViewController = sb
                    UIView.transition(with: window, duration: 0.5, options: .curveEaseInOut, animations: nil, completion: nil)
                }else{
                  displayMessage(title: "", message: (data.msg ?? "").localized, status:.error, forController: self)
                }
                
            }, onError: { (error) in
                self.reservationVM.dismissIndicator()
            }).disposed(by: disposeBag)
        }
    
    
}
