//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by five on 29/05/2021.
//

import Foundation

class QuizNetworkDataSource {
    var quizzes: [Quiz]!
    
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
    
    func getRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "iosquiz.herokuapp.com"
        urlComponents.path = "/api/quizzes"
        guard let url = urlComponents.url else {return URLRequest(url: URL(string: "")!)}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
