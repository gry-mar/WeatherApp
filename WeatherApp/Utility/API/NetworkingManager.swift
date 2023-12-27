//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation

protocol NetworkingManagerImpl {
    func request<T: Codable>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T
}


final class NetworkingManager: NetworkingManagerImpl {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(session: URLSession = .shared, _ endpoint: Endpoint, type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        let request = URLRequest(url: url)
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300
        else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
                
    }
}


extension NetworkingManager{
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self{
        case .invalidURL:
            return "URL is not valid"
        case .invalidStatusCode:
            return "Status code falls into wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let error):
            return "Somethong went wrong \(error.localizedDescription)"
        }
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        return request
    }
}
