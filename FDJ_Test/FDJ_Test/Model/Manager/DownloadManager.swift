//
//  DownloadManager.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 11/02/2021.
//

import Foundation

// This class allows us to download data
class DownloadManager: NSObject {
    
    // Call this function on the class to downlaod data
    // The escaping closure allows us to get the data in the calling scope
    // Throws an exception if the URL object cannot produce a valid URL with the url: String
    static func downloadWithURL(_ url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) throws {

        // Throws an error if the URL is faulty
        guard let url: URL = URL(string: url) else {
            completion(nil, nil, URLError(.badURL))
            throw URLError(.badURL)
        }
        
        // creating a task to download
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // if error != nil
            // so if error
            guard error == nil else {
                completion(nil, nil, error)
                return
            }
            
            completion(data, response, nil)
        }
        task.resume()
    }
    

}
