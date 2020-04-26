//
//  UIViewExtension.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
    
}


let imagecache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String, key: String) {
        let activityView = UIActivityIndicatorView(style: .gray)
        activityView.center = self.center
        self.addSubview(activityView)
        
        DispatchQueue.main.async {
            activityView.startAnimating()
        }
        
        
        guard let url = URL(string: urlString as String) else {
            DispatchQueue.main.async {
                activityView.stopAnimating()
                self.image = UIImage(named: "Image")
            }
            return
        }
        
        if let cachedImage = imagecache.object(forKey: key as AnyObject) as? UIImage {
            
            DispatchQueue.main.async {
                self.image = nil
                activityView.stopAnimating()
                self.image = cachedImage
            }
            return
        }
        
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    
                    self.image = UIImage(named: "Image")
                    activityView.stopAnimating()
                    return
                }
                
                
                self.image = nil
                activityView.stopAnimating()
                if let downloadedImage = UIImage(data: data!) {
                    imagecache.setObject(downloadedImage, forKey: key as AnyObject)
                    self.image = downloadedImage
                }
            }
            
        }).resume()
    }
}
