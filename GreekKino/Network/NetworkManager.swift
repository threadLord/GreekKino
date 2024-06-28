//
//  NetworkManager.swift
//  GreekKino
//
//  Created by Marko on 28.6.24..
//

import Foundation



protocol NetworkManagerProtocol {
    func download<T>(request: URLRequest) async -> T
}

//class NetworkManager: NetworkManagerProtocol {
//    func download<T>(request: URLRequest) async -> T {
//        return String()
//    }
//    
//    
//    
//}


