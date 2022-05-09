//
//  ServiceError.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation

enum ServiceError: Error {
    case failedToCreateRequest
    case dataNotFound
    case parsingError
    case networkNotAvailable

}
