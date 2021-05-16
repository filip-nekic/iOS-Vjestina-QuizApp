//
//  NetworkService.swift
//  QuizApp
//
//  Created by five on 15/05/2021.
//

import Foundation

class NetworkService {
    		
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping
                            (Result<T, RequestError>) -> Void) {
        // 1.
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            // 2.
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            // 3.
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.dataDecodingError))
                }
                return
            }
            // 4.
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
            
        }
        // 5.
        dataTask.resume()
    }
    
    func executeUrlRequestNoResponse(_ request: URLRequest, completionHandler: @escaping
                            (Result<String, RequestError>) -> Void) {
        // 1.
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            // 2.
            guard err == nil else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.clientError))
                }
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            // 3.
            // 4.
            DispatchQueue.main.async {
                completionHandler(.success("Success"))
            }
            
        }
        // 5.
        dataTask.resume()
    }
}
