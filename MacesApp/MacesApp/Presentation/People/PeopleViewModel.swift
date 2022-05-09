//
//  PeopleViewModel.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation
import Combine

class PeopleViewModel {
    
    private var peoples:[People] = []

    private var peopleRepository: PeopleRepositoryType
    private var cancellables:Set<AnyCancellable> = Set()

    @Published  var state: PeopleReaction = .none
    
    var numberOfPeople:Int {
        return peoples.count
    }

    init(peopleRepository: PeopleRepositoryType) {
        self.peopleRepository = peopleRepository
    }
    
    func submitAction(action: PeopleAction) {
        switch action {
        case .loadPeoples(let directoryRequest):
            self.state = .showActivityIndicator
            getPeoples(request: directoryRequest)
        }
    }
    
    func getPeople(for index: Int)-> People {
        return peoples[index]
    }
    
    private func getPeoples(request: ApiRequest) {
        
        
        let publisher = peopleRepository.getPeople(apiRequest: request)
                
        let cancalable = publisher.sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self?.peoples = []
               // self?.handleError(error: error)
            }
        } receiveValue: { [weak self ] peoples in
            self?.peoples = peoples
            self?.state = .showPeoples
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
//        self.state = States.showError(errorMessage)
//    }
}
