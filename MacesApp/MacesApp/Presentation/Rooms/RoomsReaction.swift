//
//  RoomsReaction.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation

enum RoomsReaction: Equatable {
    case showActivityIndicator
    case showRooms
    case showError(String)
    case none
}
