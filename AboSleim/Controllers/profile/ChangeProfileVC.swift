//
//  ChangeProfileVC.swift
//  Livia
//
//  Created by MAC on 16/02/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//


import UIKit
import RxSwift
import RxCocoa


class ChangeProfileVC: UIViewController {
    
    @IBOutlet weak var titleLbl  : UILabel!
    @IBOutlet weak var uploadedImage: UIImageView!
    @IBOutlet weak var usenName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var Phone: UITextField!
    @IBOutlet weak var Address: UITextField!

    private let AuthViewModel = AuthenticationViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = "changeProfile".localized
        usenName.placeholder = "userName".localized
        Email.placeholder = "email".localized
        Phone.placeholder = "phone number".localized
        Address.placeholder = "address".localized
        AuthViewModel.showIndicator()
        getProfile()
    }
    
    func DataBinding() {
        _ = usenName.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.name).disposed(by: disposeBag)
        _ = Email.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.email).disposed(by: disposeBag)
        _ = Address.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.address).disposed(by: disposeBag)
        _ = Phone.rx.text.map({$0 ?? ""}).bind(to: AuthViewModel.phone).disposed(by: disposeBag)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeProfileAction(_ sender: UIButton) {
        showImageActionSheet()
    }
    
    @IBAction func menu(_ sender: Any) {
        self.setupSideMenu()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "SearchProducts", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else { return }
        self.navigationController?.pushViewController(details, animated: true)
    }

    @IBAction func notificationhButtonPressed(_ sender: Any) {
        guard let details = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "NotificationsVC") as? NotificationsVC else { return }
        self.navigationController?.pushViewController(details, animated: true)

    }
  
    @IBAction func saveBtn(_ sender: Any) {
        self.AuthViewModel.showIndicator()
        updateProfile()
    }
    
}


extension ChangeProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImageActionSheet() {
        let chooseFromLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
                self.showImagePicker(sourceType: .photoLibrary)
            }
            let cameraAction = UIAlertAction(title: "Take a Picture from Camera", style: .default) { (action) in
                self.showImagePicker(sourceType: .camera)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            AlertService.showAlert(style: .actionSheet, title: "Pick Your Picture", message: nil, actions: [chooseFromLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.view.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.uploadedImage.image = editedImage
            
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.uploadedImage.image = originalImage
        
        }
        dismiss(animated: true, completion: nil)
    }
}

extension ChangeProfileVC {
    
    func getProfile() {
        self.AuthViewModel.getProfile().subscribe(onNext: { (data) in
            self.AuthViewModel.dismissIndicator()
            self.usenName.text = data.data?.name ?? ""
            self.Phone.text = data.data?.phone ?? ""
            self.Email.text = data.data?.email ?? ""
            self.Address.text = data.data?.address ?? ""
            self.DataBinding()
            }, onError: { (error) in
                self.AuthViewModel.dismissIndicator()
            }).disposed(by: disposeBag)
     }
    
    func updateProfile() {
        self.AuthViewModel.updateProfile().subscribe(onNext: { (data) in
          self.getProfile()
        }, onError: { (error) in
            self.AuthViewModel.dismissIndicator()
        }).disposed(by: disposeBag)
     }
    
}

