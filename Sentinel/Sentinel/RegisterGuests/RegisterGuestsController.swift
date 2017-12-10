//
//  RegisterGuestsController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

class RegisterGuestsController: UIViewController {

    let registerYourGuestsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Register your ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        
        attributedText.append(NSAttributedString(string: "guests", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let guestInfoLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "- guest information -", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        //attributedText.append(NSAttributedString(string: "vehicle!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    let guestNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Guest Name"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let vehicleInfoLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "- vehicle information -", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        //attributedText.append(NSAttributedString(string: "vehicle!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)]))
        
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
        tf.placeholder = "Car Brand"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    let vehicleModelTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Car Model"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    
    
    @objc func handleTextInputChange() {
        let isFormValid = licensePlateNumberTextField.text?.count ?? 0 > 0 && vehicleBrandTextField.text?.count ?? 0 > 0 && vehicleModelTextField.text?.count ?? 0 > 0 && guestNameTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            registerGuestsButton.isEnabled = true
            registerGuestsButton.backgroundColor = .darkBlue()
        } else {
            registerGuestsButton.isEnabled = false
            registerGuestsButton.backgroundColor = .lightBlue()
        }
    }
    
    lazy var registerGuestsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Register  ", for: .normal)
        button.backgroundColor = .lightBlue()
        button.layer.borderColor = UIColor.rgb(red: 7, green: 17, blue: 63).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleRegisterCar), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleRegisterCar() {
        
        self.saveToDatabase()
    }
    
    //static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    fileprivate func saveToDatabase() {
        //guard let imagenAuto = self.addPhotoAuto.imageView?.image else { return }
        guard let guestNameText = guestNameTextField.text else { return }
        guard let vehicleBrandText = vehicleBrandTextField.text else { return }
        guard let vehicleModelText = vehicleModelTextField.text else { return }
        guard let licensePlateNumberText = licensePlateNumberTextField.text else { return }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("Guests_of_users").child(uid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["guestName" : guestNameText,"vehicle_brand" : vehicleBrandText,"vehicle_model" : vehicleModelText,"license_plate_number" : licensePlateNumberText, "vehicle_owner_uid": uid] as [String : Any]
        
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
            
        }
    }
    
    let timeInfoLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "- time information -", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        
        //attributedText.append(NSAttributedString(string: "vehicle!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    //WHEN
    let datePicker = UIDatePicker()
    
    let  datePickerTV : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.white
        tv.textAlignment = .left
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 8, right: 5)
        tv.layer.cornerRadius = 5
        let attributedPlaceHolder = NSMutableAttributedString(string: "Arrival time", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tv.attributedText = attributedPlaceHolder
        return tv
    }()
    
    func createDatePicker(){
        
        //format for datepicker
        datePicker.datePickerMode = .dateAndTime
        
        //minimum date
        let currentDate = NSDate()
        datePicker.minimumDate = currentDate as Date
        
        //estetics
        datePicker.setValue(UIColor.rgb(red: 7, green: 17, blue: 63), forKeyPath: "textColor")
        datePicker.backgroundColor = UIColor.white
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.rgb(red: 7, green: 17, blue: 63)
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        doneButton.tintColor = UIColor.white
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTV.inputAccessoryView = toolbar
        
        //assigning datepicker to text field
        datePickerTV.inputView = datePicker
    }
    
    @objc func donePressed(){
        
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        
        datePickerTV.text = dateFormatter.string(from: datePicker.date)
        datePickerTV.attributedText = NSMutableAttributedString(string: datePickerTV.text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63)])
        datePickerTV.textContainerInset = UIEdgeInsets(top: 14, left: 5, bottom: 8, right: 5)
        datePickerTV.textContainer.maximumNumberOfLines = 0
        datePickerTV.textContainer.lineBreakMode = .byWordWrapping
        datePickerTV.isScrollEnabled = false
        self.view.endEditing(true)
    }
    
    //WHEN 2
    let datePicker2 = UIDatePicker()
    
    let  datePickerTV2 : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.white
        tv.textAlignment = .left
        tv.layer.cornerRadius = 5
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 8, right: 5)
        
        let attributedPlaceHolder = NSMutableAttributedString(string: "Departing time", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        tv.attributedText = attributedPlaceHolder
        return tv
    }()
    
    func createDatePicker2(){
        
        //format for datepicker
        datePicker2.datePickerMode = .dateAndTime
        
        //minimum date
        let currentDate = NSDate()
        datePicker2.minimumDate = currentDate as Date
        
        //estetics
        datePicker2.setValue(UIColor.rgb(red: 7, green: 17, blue: 63), forKeyPath: "textColor")
        datePicker2.backgroundColor = UIColor.white
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.rgb(red: 7, green: 17, blue: 63)
        
        //bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed2))
        doneButton.tintColor = UIColor.white
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTV2.inputAccessoryView = toolbar
        
        //assigning datepicker to text field
        datePickerTV2.inputView = datePicker2
    }
    
    @objc func donePressed2(){
        
        //format date
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .full
        dateFormatter2.timeStyle = .full
        
        datePickerTV2.text = dateFormatter2.string(from: datePicker2.date)
        datePickerTV2.attributedText = NSMutableAttributedString(string: datePickerTV2.text, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63)])
        datePickerTV2.textContainerInset = UIEdgeInsets(top: 14, left: 5, bottom: 8, right: 5)
        datePickerTV2.textContainer.maximumNumberOfLines = 0
        datePickerTV2.textContainer.lineBreakMode = .byWordWrapping
        datePickerTV2.isScrollEnabled = false
        self.view.endEditing(true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueGray()
        view.addSubview(registerYourGuestsLabel)
        registerYourGuestsLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 90, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        view.addSubview(guestInfoLabel)
        guestInfoLabel.anchor(top: registerYourGuestsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        view.addSubview(guestNameTextField)
        guestNameTextField.anchor(top: guestInfoLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        view.addSubview(vehicleInfoLabel)
        vehicleInfoLabel.anchor(top: guestNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        let vehicleInfoStackView = UIStackView(arrangedSubviews: [vehicleBrandTextField, vehicleModelTextField, licensePlateNumberTextField])
        
        vehicleInfoStackView.axis = .vertical
        vehicleInfoStackView.spacing = 10
        vehicleInfoStackView.distribution = .fillEqually
        
        view.addSubview(vehicleInfoStackView)
        vehicleInfoStackView.anchor(top: vehicleInfoLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 150)
        
        
        view.addSubview(timeInfoLabel)
        timeInfoLabel.anchor(top: vehicleInfoStackView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 0)
        
        createDatePicker()
        createDatePicker2()
        
        view.addSubview(datePickerTV)
        datePickerTV.anchor(top: timeInfoLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        view.addSubview(datePickerTV2)
        datePickerTV2.anchor(top: datePickerTV.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        
        view.addSubview(registerGuestsButton)
        registerGuestsButton.anchor(top: datePickerTV2.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        registerGuestsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
