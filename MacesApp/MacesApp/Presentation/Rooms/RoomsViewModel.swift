//
//  RoomsViewModel.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation
import Combine

class RoomsViewModel {
    
    private var rooms:[Room] = []
    private var roomsRepository: RoomsRepositoryType

    @Published  var state: RoomsReaction = .none
    private var cancellables:Set<AnyCancellable> = Set()

    var numberOfRooms:Int {
        return rooms.count
    }

    init(roomsRepository: RoomsRepositoryType) {
        self.roomsRepository = roomsRepository
    }
    
    func submitAction(action: RoomsActions) {
        switch action {
        case .loadRooms(let apiRequest):
            self.state = .showActivityIndicator
            getRooms(apiRequest: apiRequest)
        }
    }
    
    func getRoom(for index: Int)-> Room {
        return rooms[index]
    }
    
    private func getRooms(apiRequest: ApiRequest) {
        let publisher =   self.roomsRepository.getRooms(apiRequest: apiRequest)
        
        let cancalable = publisher.sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.rooms = []
               // self?.handleError(error: error)
            }
        } receiveValue: { [weak self ] rooms in
            self?.rooms = rooms
            self?.state = .showRooms
        }
        self.cancellables.insert(cancalable)
    }
    
//    private func handleError(error: ApiError) {
//        var errorMessage = ""
//        switch error {
//        case .UrlNotCorrect(let message):
//            errorMessage = message
//        case .recieveNilResponse(let message):
//            errorMessage = message
//        case .recieveErrorHttpStatus(let message):
//            errorMessage = message
//        case .recieveNilBody(let message):
//            errorMessage = message
//        case .failedParse(let message):
//            errorMessage = message
//        case .customError(let message):
//            errorMessage =  "\(Constants.failedMessage) \(message)"
//        }
//        self.state = .showError(errorMessage)
//    }
}
