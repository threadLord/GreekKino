//
//  NetworkError.swift
//  GreekKino
//
//  Created by Marko on 1.7.24..
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case requestFailed
}
