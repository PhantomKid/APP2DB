//
//  NetworkManager.swift
//  APP2DB
//
//  Created by Kai on 2024/12/11.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "http://10.46.29.143:3000"
    
    private init() {}

    // 通用请求方法，用于获取数据
    func fetchData<T: Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        task.resume()
    }

    // 动态查询方法，支持条件查询
    func queryData<T: Decodable>(endpoint: String, parameters: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
        var urlComponents = URLComponents(string: baseURL + endpoint)!
        urlComponents.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
        task.resume()
    }
    
    // 网络请求错误类型
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
