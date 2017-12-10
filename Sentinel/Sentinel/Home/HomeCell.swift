//
//  HomeCell.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    
    let label : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Vicente has just entered Vista Poniente Edificio"
        label.textAlignment = .left
        label.textColor = .darkBlue()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
