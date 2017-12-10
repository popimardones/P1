//
//  RegisterVehicleController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

class RegisterVehicleController: UIViewController, UINavigationControllerDelegate {
    
    let registerYourVehicleLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Register your ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        
        attributedText.append(NSAttributedString(string: "vehicle", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let licensePlateNumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "License Plate Number"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let vehicleBrandTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Vehicle Brand"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let vehicleModelTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Vehicle Model"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    
    
    @objc func handleTextInputChange() {
        let isFormValid = licensePlateNumberTextField.text?.count ?? 0 > 0 && vehicleBrandTextField.text?.count ?? 0 > 0 && vehicleModelTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            registerVehicleButton.isEnabled = true
            registerVehicleButton.backgroundColor = .darkBlue()
        } else {
            registerVehicleButton.isEnabled = false
            registerVehicleButton.backgroundColor = .lightBlue()
        }
    }
    
    lazy var registerVehicleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Register  ", for: .normal)
        button.backgroundColor = .lightBlue()
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleRegisterVehicle), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleRegisterVehicle() {
     
        self.saveToDatabase()
    }
   
    static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateProfile")
    
    fileprivate func saveToDatabase() {
        //guard let imagenAuto = self.addPhotoAuto.imageView?.image else { return }
        guard let vehicleBrandText = vehicleBrandTextField.text else { return }
        guard let vehicleModelText = vehicleModelTextField.text else { return }
        guard let licensePlateNumberText = licensePlateNumberTextField.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("Vehicles_of_users").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["vehicle_brand" : vehicleBrandText,"vehicle_model" : vehicleModelText,"license_plate_number" : licensePlateNumberText, "vehicle_owner_uid": uid] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("Failed to save post to DB", err)
                return
            }
            
            print("Successfully saved post to DB")
            
            //-----------------------------------------
            
            guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
            tabBarController.setupViewControllers()
            
            
            self.dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: RegisterVehicleController.updateFeedNotificationName, object: nil)

            
        }
    }
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No thanks!", for: .normal)
        //button.backgroundColor = .darkBlue()
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    @objc func handleSkip() {
      
        guard let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? TabBarController else { return }
        tabBarController.setupViewControllers()
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueGray()
        view.addSubview(registerYourVehicleLabel)
        registerYourVehicleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 90, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        let vehicleInfoStackView = UIStackView(arrangedSubviews: [vehicleBrandTextField, vehicleModelTextField, licensePlateNumberTextField])
        
        vehicleInfoStackView.axis = .vertical
        vehicleInfoStackView.spacing = 10
        vehicleInfoStackView.distribution = .fillEqually
        
        view.addSubview(vehicleInfoStackView)
        vehicleInfoStackView.anchor(top: registerYourVehicleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
        
        view.addSubview(registerVehicleButton)
        registerVehicleButton.anchor(top: vehicleInfoStackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        registerVehicleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
//        //if first time----------------
//        view.addSubview(skipButton)
//        skipButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
//        //-------------
        setupNavigationButtons()
        
        // Allows dismissal of keyboard on tap anywhere on screen besides the keyboard itself
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .darkBlue()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status and drop into background
        view.endEditing(true)
    }

}
