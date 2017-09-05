//
//  GTKTGitHubRequest.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

public struct GitHubRequest {

    public static func makeRequest(urlString: String, completionHandler: @escaping (_ data: Any?) -> Void) {
        guard let url = URL(string: urlString) else {
            assertionFailure("Invalid URL string")
            completionHandler(nil)
            return
        }

        let session = URLSession.shared
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) {
            data, response, error in

            guard error == nil else {
                completionHandler(nil)
                return
            }

            guard let data = data else {
                completionHandler(nil)
                return
            }

            completionHandler(data)
        }

        task.resume()
    }
    
}
