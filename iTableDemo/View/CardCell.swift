//
//  CardCell.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit


struct CardVM {
  var cardTitle : String
  var cardImage : String
  var cardDescription : String
}
    
class CardCell : UITableViewCell {
    
    var card : CardVM? {
        didSet {
            cardImage.image = nil
            cardImage.loadImageUsingCacheWithUrlString(urlString: card?.cardImage ?? "", key: card?.cardTitle ?? "")
            lblCardTitle.text = card?.cardTitle
            lblCardDescription.text = card?.cardDescription
        }
    }
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private let lblCardTitle : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    private let lblCardDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let cardImage : UIImageView = {
        
        let imgView = UIImageView(image: UIImage(named: "Image"))
        
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardImage)
        addSubview(lblCardTitle)
        addSubview(lblCardDescription)
        
        cardImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 200, enableInsets: false)
        lblCardTitle.anchor(top: cardImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 50, height: 0, enableInsets: false)
        lblCardDescription.anchor(top: lblCardTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 50, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

