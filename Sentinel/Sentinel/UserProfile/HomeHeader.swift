//
//  HomeHeader.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//


import UIKit
import Firebase

protocol HomeHeaderDelegate {

}

class HomeHeader: UICollectionViewCell {
    
    var delegate: HomeHeaderDelegate?
    
    let logoContainerView: UIView = {
        let view = UIView()
        
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "SentinelBannerHomeController"))
        logoImageView.contentMode = .scaleAspectFill
        
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 166)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.backgroundColor = .darkBlue()
        return view
    }()
    
    
    
    let activityLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "  Activity in your community", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)])
        
        //attributedText.append(NSAttributedString(string: "car!", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24)]))
        
        label.attributedText = attributedText
        label.backgroundColor = UIColor.rgb(red: 103, green: 112, blue: 154)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let seperatorView1: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.rgb(red: 103, green: 112, blue: 154)
        return view
    }()
    
    let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor =  UIColor.rgb(red: 103, green: 112, blue: 154)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoContainerView)
        logoContainerView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 166)
        
//        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "SentinelBannerHomeController"))
//        logoImageView.contentMode = .scaleAspectFill
//
//        addSubview(logoImageView)
//        logoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 166)
//        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(seperatorView1)
        seperatorView1.anchor(top: logoContainerView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        
        addSubview(activityLabel)
        activityLabel.anchor(top: seperatorView1.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 25)
        
        addSubview(seperatorView2)
        seperatorView2.anchor(top: activityLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        
        
       
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


