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
        let topInset = CGFloat(0)
        let bottomInset = CGFloat(0)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
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
        //check cache for image first
        if let cachedImage = imagecache.object(forKey: key as AnyObject) as? UIImage {
            
            DispatchQueue.main.async {
                self.image = nil
                self.image = cachedImage
            }
            return
        }
        
        //otherwise fire off a new download
        let urlStr : NSString = urlString as NSString
        let url = NSURL(string: urlString as String)
        
        //let request:NSURLRequest = NSURLRequest(url: url as! URL)
        
        guard let imgUrl = URL(string: urlStr as String) else {
            return
        }
        let request = URLRequest(url: imgUrl, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60)
        
        //Get cache response using request object
        let cacheResponse = URLCache.shared.cachedResponse(for:request)
        
        if cacheResponse == nil {
            
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if error != nil {
                    return
                }
                
                DispatchQueue.main.async {
                    
                    let cacheResponse = CachedURLResponse(response: response!, data: data!)
                    URLCache.shared.storeCachedResponse(cacheResponse, for: request)
                    
                    
                    if let downloadedImage = UIImage(data: data!) {
                        imagecache.setObject(downloadedImage, forKey: key as AnyObject)
                        self.image = nil
                        self.image = downloadedImage
                    }
                }
                
            }).resume()
        }
    }
}
