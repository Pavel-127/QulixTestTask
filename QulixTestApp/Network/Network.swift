//
//  Network.swift
//  QulixTestApp
//
//  Created by macbook on 22.02.22.
//

import Foundation

class Network {
    
    static let sh = Network()
    
    private let baseUrl: String = "https://api.themoviedb.org/3/"
    private let imageURL: String = "https://image.tmdb.org/t/p/w200/"
    
    private let api_key: String = "79d5894567be5b76ab7434fc12879584"
    
    
    private lazy var parameters: [String: String] = [
        "api_key": self.api_key
    ]
    
    private let session = URLSession(configuration: .default)
    
    private init() {}
    
    func request(urlPath: String,
                 parameters: [String: String]? = nil,
                 okHandler: @escaping (Response) -> Void,
                 errorHendler: @escaping () -> Void) {
        var urlParameters = self.parameters
        
        parameters?.forEach {
            urlParameters[$0.key] = $0.value
        }
        
        guard let url = URL(urlString: self.baseUrl,
                            path: urlPath,
                            params: urlParameters) else {
            return
        }
        
        let reqest = URLRequest(url: url)
        
        let dataTask = self.session.dataTask(with: reqest) { (data, response, error) in
            if let error = error {
                Swift.debugPrint(error.localizedDescription)
                DispatchQueue.main.async {
                    errorHendler()
                }
            } else if let data = data,
                      let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...300:
                    do {
                        let model = try JSONDecoder().decode(Response.self, from: data)
                        DispatchQueue.main.async {
                            okHandler(model)
                        }
                    } catch let error {
                        Swift.debugPrint(error.localizedDescription)
                        DispatchQueue.main.async {
                            errorHendler()
                        }
                    }
                case 401, 404:
                    Swift.debugPrint(String(decoding: data, as: UTF8.self))
                    DispatchQueue.main.async {
                        errorHendler()
                    }
                default:
                    DispatchQueue.main.async {
                        errorHendler()
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
