//
//  UserProfileHeader.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/25/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

protocol UserProfileHeaderDelegate {
    func showRegisterVehicle()

}


class UserProfileHeader: UICollectionReusableView {
    
    var delegate: UserProfileHeaderDelegate?
    
    var currentUser: User? {
        didSet {
            guard let profileImageUrl = currentUser?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            //------------number of vehicles register-------------------------
            
            guard let numVehiclesRegistered = currentUser?.numberOfVehiclesRegistered else { return }
            let numVehiclesRegisteredString = String(numVehiclesRegistered)
            let numVehiclesAttributedText = NSMutableAttributedString(string: numVehiclesRegisteredString, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white])
            
            numVehiclesAttributedText.append(NSAttributedString(string: "  vehicles registered", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68)
                ]))
            
            numberOfVehiclesRegisteredLabel.attributedText = numVehiclesAttributedText
            
        }
    }

    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.borderColor = UIColor.rgb(red: 8, green: 19, blue: 68).cgColor
        iv.layer.borderWidth = 2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    //num vehicles register
    let numberOfVehiclesRegisteredLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: " vehicles registered", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    
    let seperatorView1: UIView = {
        let view = UIView()
//        view.backgroundColor =  UIColor.rgb(red: 103, green: 112, blue: 154)
        view.backgroundColor =  .darkBlue()

        return view
    }()
    
    lazy var registerVehicleButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleRegisterVehicle), for: .touchUpInside)
        button.setTitle("  Registar a vehicle  ", for: .normal)
//        button.layer.cornerRadius = 3
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = .darkBlue()
        button.backgroundColor = .lightBlue()
        button.layer.borderColor = UIColor.rgb(red: 7, green: 17, blue: 63).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    @objc func handleRegisterVehicle(){
        
//        let registerVehicleController = RegisterVehicleController()
//        let navController = UINavigationController(rootViewController: registerVehicleController)
//
//        present(navController, animated: true, completion: nil)
        print("handling register vehicle from the header")
        delegate?.showRegisterVehicle()
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor.rgb(red: 131, green: 139, blue: 160)
        
        //navigationController?.navigationBar.tintColor = .darkBlue()

        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        //profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        let stackView = UIStackView(arrangedSubviews: [numberOfVehiclesRegisteredLabel,registerVehicleButton])
        addSubview(stackView)
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 35)
        
        
        addSubview(seperatorView1)
        seperatorView1.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
