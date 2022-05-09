//
//  RoomsResponce.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation

struct RoomsData: Decodable {
    var createdAt: String
    var isOccupied: Bool
    var maxOccupancy: Int
    var id: String
}
