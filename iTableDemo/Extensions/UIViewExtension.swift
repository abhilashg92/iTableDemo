//
//  UIViewExtension.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

let imagecache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// Function to download and cache image from ur
    /// - Parameters:
    ///   - urlString: url for downloading image
    ///   - key: key for saving image chache
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
        
        URLSession.shared.dataTask(with: url as URL, completionHandler: { (data, _, error) in
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
