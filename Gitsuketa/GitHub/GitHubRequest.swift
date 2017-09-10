//
//  GTKTGitHubRequest.swift
//  Gitsuketa
//
//  Created by Maddin on 05.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubRequest {

    fileprivate static let clientID = "55e5e0c32d50541646b4"
    fileprivate static let clientSecret = "0d7e5371c74cd29c2649261c92fc03ca24696010"

    static func makeRequest(search: GitHubSearchParameter, completionHandler: @escaping (_ gitHubSearchResult: GitHubSearchResult?) -> Void) {
        let clientIDSecret = "&client_id=\(clientID)&client_secret=\(clientSecret)"
        let urlString = search.url + clientIDSecret
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURL) else {
            assertionFailure()
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

            guard let response = response as? HTTPURLResponse else {
                return
            }
            print("\(response.statusCode)") //200 ok // 403 exceeded
            print("X-RateLimit-Remaining \(response.allHeaderFields["X-RateLimit-Remaining"] ?? "")")

            guard let data = data else {
                completionHandler(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let searchResult = try decoder.decode(GitHubSearchResult.self, from: data)
                completionHandler(searchResult)
            } catch {
                completionHandler(nil)
                print("error trying to convert data to JSON")
                print(error)
            }
        }

        task.resume()
    }
    
}
