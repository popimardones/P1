//
//  VehiclesRegisteredCell.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/26/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit

protocol VehiclesRegisteredCellDelegate {
    //func didTapComment(post: Post)
    //func didPressGoing(for cell: HomePostCell)
}

class VehiclesRegisteredCell: UICollectionViewCell {
    
    var vehiclesRegisteredCellDelegate: VehiclesRegisteredCellDelegate?
    
    var vehicle: Vehicle? {
        didSet {
            
            //brand
            
            guard let brandText = vehicle?.vehicleBrand else { return }
            print(brandText)
            let attributedBrandText = NSMutableAttributedString(string: "  Vehicle brand: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedBrandText.append(NSAttributedString(string: brandText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
            brandLabel.attributedText = attributedBrandText
            
            //model
            guard let modelText = vehicle?.vehicleModel else { return }
            print(modelText)
            let attributedModelText = NSMutableAttributedString(string: "  Vehicle model: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedModelText.append(NSAttributedString(string: modelText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
            modelLabel.attributedText = attributedModelText
            
            //license plate
            guard let licensePlateText = vehicle?.licensePlateNumber else { return }
            print(licensePlateText)
            let attributedLicensePlateText = NSMutableAttributedString(string: "  License plate number: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            attributedLicensePlateText.append(NSAttributedString(string: licensePlateText, attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
            licensePlateNumberLabel.attributedText = attributedLicensePlateText
        }
    }
    
    
    let brandLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
//        let attributedText = NSMutableAttributedString(string: "  Vehicle brand: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
//
//        attributedText.append(NSAttributedString(string: "Suzuki", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
//
//        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let modelLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
//        let attributedText = NSMutableAttributedString(string: "  Vehicle model: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
//
//        attributedText.append(NSAttributedString(string: "Swift", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
//
//        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    let licensePlateNumberLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
//        let attributedText = NSMutableAttributedString(string: "  License plate number: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
//        
//        attributedText.append(NSAttributedString(string: "FSH11G1", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
//        
//        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
//    let communityNameLabel : UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        let attributedText = NSMutableAttributedString(string: "  Community name: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
//
//        attributedText.append(NSAttributedString(string: "Silos de Torobayo", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
//
//        label.attributedText = attributedText
//        label.numberOfLines = 0
//        return label
//    }()
    
//    let seperatorView1: UIView = {
//        let view = UIView()
//        //view.backgroundColor =  UIColor.rgb(red: 103, green: 112, blue: 154)
//        view.backgroundColor =  UIColor.darkGray
//
//        return view
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(brandLabel)
        brandLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
        addSubview(modelLabel)
        modelLabel.anchor(top: brandLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
        addSubview(licensePlateNumberLabel)
        licensePlateNumberLabel.anchor(top: modelLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
        
//        addSubview(communityNameLabel)
//        communityNameLabel.anchor(top: licensePlateNumberLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
//        addSubview(seperatorView1)
//        seperatorView1.anchor(top: label.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

