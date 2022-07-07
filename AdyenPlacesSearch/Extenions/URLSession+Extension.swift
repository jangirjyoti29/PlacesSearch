//
//  URLSession+Extension.swift
//  AdyenPlacesSearch
//
//  Created by REINA on 06/07/22.
//

import Foundation


extension URLSession {
    enum APIError:Error {
        case invalidURL
        case invalidData
    }
    
    func request<T: Codable>(url:URL?, expecting:T.Type, headers:[String:String], complition: @escaping (Result<T, Error>) -> ()) {
        guard let url = url else {
            complition(.failure(APIError.invalidURL))
            return
        }
        let request = NSMutableURLRequest(url: url,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.allHTTPHeaderFields = headers
        let task = dataTask(with: request as URLRequest) { data, _ , error in
            guard let data = data else {
                if let error = error {
                    complition(.failure(error))
                }else {
                    complition(.failure(APIError.invalidData))
                }
                return
            }
            do {
                let value = try JSONDecoder().decode(expecting, from:data)
                complition(.success(value ))
            } catch {
                complition(.failure(error))
            }
        }
        task.resume()
    }
    
    func load(url:URL, headers:[String:String], complition: @escaping (Data?, Error?) -> ()) {
        let request = NSMutableURLRequest(url: url,cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.allHTTPHeaderFields = headers
        let task = dataTask(with: request as URLRequest) { data, _ , error in
            guard let data = data else {
                if let error = error {
                    complition(nil, error)
                }else {
                    complition(nil, APIError.invalidData)
                }
                return
            }
            complition(data, nil)
        }
        task.resume()
    }
}
