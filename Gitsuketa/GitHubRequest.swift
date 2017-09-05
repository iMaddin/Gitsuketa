//
//  GTKTGitHubRequest.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

public struct GitHubRequest {

    public static func makeRequest(urlString: String, completionHandler: @escaping (_ json: [String: Any]?) -> Void) {
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

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completionHandler(json)
                }
            } catch let error {
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }

        task.resume()
    }
    
}
