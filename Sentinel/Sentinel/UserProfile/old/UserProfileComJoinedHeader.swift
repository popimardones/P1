//
//  UserProfileComJoinedHeader.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/26/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

protocol UserProfileComJoinedHeaderDelegate {
    func showJoinCommunity()
    
}


class UserProfileComJoinedHeader: UICollectionReusableView {
    
    var delegate: UserProfileComJoinedHeaderDelegate?
    
    var currentUser: User? {
        didSet {
            
            //------------number of cars register-------------------------
            
            guard let numCommunitiesJoined = currentUser?.numberOfCommunitiesJoined else { return }
            let numCommunitiesJoinedString = String(numCommunitiesJoined)
            let numCommunitiesAttString = NSMutableAttributedString(string: numCommunitiesJoinedString, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white])
            
            numCommunitiesAttString.append(NSAttributedString(string: " cars registered", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68)
                ]))
            
            numberOfCommunitiesJoinedLabel.attributedText = numCommunitiesAttString
            
        }
    }
    

    
    //num cars register
    let numberOfCommunitiesJoinedLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16)])
        
        attributedText.append(NSAttributedString(string: " communities joined", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68), NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)]))
        
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
    
    
    lazy var joinCommunityButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleJoinCommunity), for: .touchUpInside)
        button.setTitle("  Join a community  ", for: .normal)
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
    
    @objc func handleJoinCommunity(){
        
        //        let joinCommunityController = JoinCommunityController()
        //        let navController = UINavigationController(rootViewController: joinCommunityController)
        //
        //        present(navController, animated: true, completion: nil)
        
        print("handling join community from the header")
        delegate?.showJoinCommunity()
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
        let stackView = UIStackView(arrangedSubviews: [numberOfCommunitiesJoinedLabel,joinCommunityButton])
        addSubview(stackView)
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 30, width: 0, height: 35)
        
        
        addSubview(seperatorView1)
        seperatorView1.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 3)
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
