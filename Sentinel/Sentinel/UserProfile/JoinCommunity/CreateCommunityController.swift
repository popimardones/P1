//
//  CreateCommunityController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/24/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

class CreateCommunityController: UIViewController, UINavigationControllerDelegate {
    
    let registerYourCarLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Create a ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        
        attributedText.append(NSAttributedString(string: "community", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let communityNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "communityName"
        tf.backgroundColor = UIColor.white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
        return tf
    }()
    
    
    
    
    
    @objc func handleTextInputChange() {
        let isFormValid = communityNameTextField.text?.count ?? 0 > 0
        
        if isFormValid {
            createButton.isEnabled = true
            createButton.backgroundColor = .darkBlue()
        } else {
            createButton.isEnabled = false
            createButton.backgroundColor = .lightBlue()
        }
    }
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Create  ", for: .normal)
        button.backgroundColor = .lightBlue()
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleCreateCommunity), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    @objc func handleCreateCommunity() {
        
        self.saveToDatabase()
    }
    
    //static let updateFeedNotificationName = NSNotification.Name(rawValue: "UpdateFeed")
    
    fileprivate func saveToDatabase() {
        //guard let imagenAuto = self.addPhotoAuto.imageView?.image else { return }
        guard let communityName = communityNameTextField.text else { return }
        
        guard let communityAdminUid = Auth.auth().currentUser?.uid else { return }
        
        let userPostRef = Database.database().reference().child("Communities").child(communityAdminUid)
        let ref = userPostRef.childByAutoId()
        
        let values = ["community_name" : communityName, "community_admin_uid": communityAdminUid] as [String : Any]
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueGray()
        view.addSubview(registerYourCarLabel)
        registerYourCarLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 90, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        let communityInfoStackView = UIStackView(arrangedSubviews: [communityNameTextField])
        
        communityInfoStackView.axis = .vertical
        //communityInfoStackView.spacing = 10
        communityInfoStackView.distribution = .fillEqually
        
        view.addSubview(communityInfoStackView)
        communityInfoStackView.anchor(top: registerYourCarLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 40)
        
        view.addSubview(createButton)
        createButton.anchor(top: communityInfoStackView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
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
