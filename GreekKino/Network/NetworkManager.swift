//
//  NetworkManager.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation



protocol NetworkManagerProtocol {
    func download<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T
}

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case requestFailed
}

struct NetworkManager: NetworkManagerProtocol {
    func download<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }
            
            do {
                let response: T = try JSONDecoder().decode(T.self, from: data)
                return response
            } catch {
                throw NetworkError.decodingError
            }
            
        } catch {
            throw NetworkError.requestFailed
        }
    }
}
