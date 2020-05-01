//
//  CardCell.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

struct CardVM {
  var cardTitle: String
  var cardImage: String
  var cardDescription: String
}
    
class CardCell: UITableViewCell {
    
    var card: CardVM? {
        didSet {
            cardImage.image = nil
            cardImage.loadImageUsingCacheWithUrlString(urlString: card?.cardImage ?? "", key: card?.cardTitle ?? "")
            lblCardTitle.text = card?.cardTitle
            lblCardDescription.text = card?.cardDescription
        }
    }
        
    private let lblCardTitle: UILabel = {
        let lbl = UILabel()
         lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let lblCardDescription: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let cardImage: UIImageView = {
        
        let imgView = UIImageView(image: UIImage(named: "Image"))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    /// Function to set up layout of all ui elements
    fileprivate func setupLayout() {
        cardImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cardImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        lblCardTitle.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 10).isActive = true
        lblCardTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblCardTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        lblCardDescription.topAnchor.constraint(equalTo: lblCardTitle.bottomAnchor, constant: 10).isActive = true
        lblCardDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        lblCardDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        lblCardDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cardImage)
        addSubview(lblCardTitle)
        addSubview(lblCardDescription)
                
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
