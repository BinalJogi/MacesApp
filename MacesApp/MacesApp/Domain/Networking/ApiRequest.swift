//
//  ApiRequest.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation

protocol ApiRequestType {
    var baseUrl: String {get}
    var path: String {get}
    var params: [String:String] {get}
}

struct ApiRequest:ApiRequestType {
    var baseUrl: String
    var path: String
    var params: [String : String]
}
