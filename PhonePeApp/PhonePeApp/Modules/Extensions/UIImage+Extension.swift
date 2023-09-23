//
//  UIImage+Extension.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import UIKit

extension UIImageView {
    
    static let imageCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject,AnyObject>()
        cache.totalCostLimit = 10*1024*1024
        return cache
    }()
    
    
    var url: String {
        
        get{
            return ""
        }
        set{
            let imageCache = UIImageView.imageCache
            
            if let data = imageCache.object(forKey: newValue as AnyObject) as? Data {
                // data found in cache
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            } else {
                // data not found in cache so storing the url and then making the request
                guard let URL = URL(string: newValue) else { return }
                let session = URLSession.shared
                let task = session.dataTask(with: URL) { (data, response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        guard let data = data else { return }
                        imageCache.setObject(data as AnyObject, forKey: newValue as AnyObject)
                        DispatchQueue.main.async {
                            self.image = UIImage(data: data)
                        }
                    }
                }
                task.resume()
            }
            
        }
    }
}
