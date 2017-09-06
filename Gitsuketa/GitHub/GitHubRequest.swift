//
//  GTKTGitHubRequest.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

public struct GitHubRequest {

    public static func makeRequest(urlString: String, completionHandler: @escaping (_ gitHubSearchResult: GitHubSearchResult?) -> Void) {
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

            let decoder = JSONDecoder()
            do {
                let searchResult = try decoder.decode(GitHubSearchResult.self, from: data)
                completionHandler(searchResult)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
            }
        }

        task.resume()
    }
    
}
