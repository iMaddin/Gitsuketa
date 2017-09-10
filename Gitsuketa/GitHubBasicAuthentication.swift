//
//  GitHubBasicAuthentication.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import Foundation

struct GitHubBasicAuthentication {

    static func authenticate(username: String, password: String, authenticationCode: String?, completionHandler: ((Bool) -> Void)? = nil) {
        let loginString = "\(username):\(password)"
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            assertionFailure("Encoding login data failed")
            return
        }
        let base64LoginString = loginData.base64EncodedString()

        // create the request
        guard let url = URL(string: "https://api.github.com") else {
            assertionFailure()
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

        if let authenticationCode = authenticationCode,
            let authenticationData = authenticationCode.data(using: String.Encoding.utf8) {
            let base64AuthenticationString = authenticationData.base64EncodedString()
            request.setValue(authenticationCode, forHTTPHeaderField: "X-GitHub-OTP")
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request) {
            data, response, error in

            guard error == nil else {
                completionHandler?(false)
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completionHandler?(false)
                return
            }
            print("Response: \(response.statusCode)") // 404 auth code not working


            guard let data = data else {
                completionHandler?(false)
                return
            }

            let dataString = String(data: data, encoding: String.Encoding.utf8)
            print(dataString)
            completionHandler?(true)

        }

        task.resume()
    }

}
