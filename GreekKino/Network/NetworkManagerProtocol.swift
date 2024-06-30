//
//  NetworkManagerProtocol.swift
//  GreekKino
//
//  Created by Marko on 1.7.24..
//

import Foundation

protocol NetworkManagerProtocol {
    init(session: URLSession)
    
    func download<T: Decodable>(request: URLRequest, type: T.Type) async throws -> T
    func upload<T: Codable>(request: URLRequest, data: Data, type:T.Type) async throws -> T
}
