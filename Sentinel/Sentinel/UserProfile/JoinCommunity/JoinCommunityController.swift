//
//  JoinCommunityController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//
import UIKit
import Firebase

class JoinCommunityController: UIViewController, UISearchBarDelegate {
    
    
    let joinYourCommunityLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Join a ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)])
        
        attributedText.append(NSAttributedString(string: "community", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var communitiesSearchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Enter a community key"
        sb.barTintColor = .gray
        sb.setTextFieldColor(color: UIColor.white)
        sb.setStyleColor(UIColor.lightGray)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
        sb.delegate = self
        return sb
    }()
    
    lazy var joinCommunityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("join", for: .normal)
        //button.backgroundColor = .darkBlue()
        
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleJoinCommunity), for: .touchUpInside)
        
        button.isEnabled = false
        
        return button
    }()
    
    var community: Community?
    
    @objc func handleJoinCommunity() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let communityId = community?.uid else { return }
        
        //follower /add person to follower
        let refUsersInCom = Database.database().reference().child("Users_in_community").child(communityId)
        
        let joinValues = [currentLoggedInUserId: 1]
        refUsersInCom.updateChildValues(joinValues) { (err, ref) in
            if let err = err {
                print("Failed to add person to community:", err)
                return
            }
            
            print("Successfully added person to community: ", self.community?.communityName ?? "")
            
            
        }
    }
    
    let orCreateACommunityButton: UIButton = {
        let button = UIButton(type: .system)
        
        let attributedTitle = NSMutableAttributedString(string: "- or create a ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: "community -", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68)
            ]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.addTarget(self, action: #selector(handleShowCreateCommunity), for: .touchUpInside)
        return button
    }()
    
    @objc func handleShowCreateCommunity() {
        let createCommunityController = CreateCommunityController()
        let navController = UINavigationController(rootViewController: createCommunityController)
        
        present(navController, animated: true, completion: nil)
    }
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("skip", for: .normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        
        button.isEnabled = true
        
        return button
    }()
    
    @objc func handleSkip() {
        
//        let registerCarController = RegisterCarController()
//        let navController = UINavigationController(rootViewController: registerCarController)
//
//        present(navController, animated: true, completion: nil)
        
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blueGray()
        
        view.addSubview(joinYourCommunityLabel)
        joinYourCommunityLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 90, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0)
        
        view.addSubview(communitiesSearchBar)
        communitiesSearchBar.anchor(top: joinYourCommunityLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: 0, height: 0)
       
        view.addSubview(orCreateACommunityButton)
        orCreateACommunityButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
//        view.addSubview(skipButton)
//        skipButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0)
        
        // Allows dismissal of keyboard on tap anywhere on screen besides the keyboard itself
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupNavigationButtons()

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
