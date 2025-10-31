//
//  NetworkService.swift
//  Dota2Tracker
//
//  Created by Михаил Кушаков on 30.10.2025.
//

import Foundation

class NetworkService {
    var url: URL?
    var request: URLRequest?
    
    func sendRequest(name: String, completion: @escaping ([Player]) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "dota2-telegram-bot-production.up.railway.app"
        urlComponents.path = "/player/search"
        urlComponents.queryItems = [URLQueryItem(name: "nickname", value: name)]
        
        self.url = urlComponents.url
        
        if let url = url {
            request = URLRequest(url: url)
            request?.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request!) { data, response, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                if let jsonData = data {
                    do {
                        let playerResponse = try JSONDecoder().decode(Welcome.self, from: jsonData)
                        completion(playerResponse.players)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
}
