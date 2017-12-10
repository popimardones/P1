//
//  CommunitiesJoinedCell.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/26/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit

protocol CommunitiesJoinedCellDelegate {
    //func didTapComment(post: Post)
    //func didPressGoing(for cell: HomePostCell)
}

class CommunitiesJoinedCell: UICollectionViewCell {
    
    var communitiesJoinedCellDelegate: CommunitiesJoinedCellDelegate?

    
    let communityNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let attributedText = NSMutableAttributedString(string: "  Community name: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "Silos de Torobayo", attributes: [NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 7, green: 17, blue: 63), NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(communityNameLabel)
        communityNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

