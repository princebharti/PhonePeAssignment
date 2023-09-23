//
//  DataManager.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//


import Foundation

class DataManager {
    
 
    static func loadData<T: Codable>(forEndPoint url: String, completionHandler: @escaping (T?,Error?) -> Void) {
        
        let apiURL = URL(string: url)
        guard let url = apiURL else {
            completionHandler(nil, NSError(domain: "URL not valid", code: 9000))
            return
            
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completionHandler(nil, error)
            } else {
                guard let data = data else {
                    completionHandler(nil, NSError(domain: "Somw Error occured", code: 9001))
                    return
                    
                }
                
                let decoder = JSONDecoder()
                do {
                    let jsonDecodedData = try decoder.decode(T.self, from: data)
                    completionHandler(jsonDecodedData, nil)
                    
                } catch {
                    print()
                    completionHandler(nil, NSError(domain: error.localizedDescription, code: 9002))
                }
            }
        }
        task.resume()
        
    }
    
}
