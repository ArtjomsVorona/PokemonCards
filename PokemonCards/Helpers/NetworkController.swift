//
//  NetworkController.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 26/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Put = "PUT"
        case Post = "POST"
        case Patch =  "PATCH"
        case Delete = "DELETE"
    }
    
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               urlParameters: [String: String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
        let requestUrl = self.url(byAdding: urlParameters, to: url)
        var request = URLRequest(url: requestUrl)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion?(data, error)
        }
        dataTask.resume()
    }
    
    static func url(byAdding parameters: [String: String]?, to url: URL) -> URL {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        guard let url = components?.url else {
            fatalError("URL components is nil")
        }
        
        return url
    }
    
}//end class
