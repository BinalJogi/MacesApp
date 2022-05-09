//
//  RoomsRepository.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation
import Combine

protocol RoomsRepositoryType {
    func getRooms(apiRequest:ApiRequestType)->Future<[Room], ServiceError>

}

class RoomsRepository: RoomsRepositoryType {
 
     
    let networkManager: Networkable

    var cancellables:Set<AnyCancellable?> = Set()

    init(networkManager:Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getRooms(apiRequest: ApiRequestType) -> Future<[Room], ServiceError> {

        return Future { [unowned self] promise in

            let apiCallPublisher =   self.networkManager.doApiCall(apiRequest: apiRequest)
            
            let cancellable =  apiCallPublisher.sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    return promise(.failure(error))
                }
                
            } receiveValue: {  data in
                guard let decodedResponse = try? JSONDecoder().decode([RoomsData].self, from: data) else {
                    return promise(.failure(ServiceError.parsingError))
                }
                
               let rooms = decodedResponse.map {
                   Room(createdAt: $0.createdAt, occupiedMessage:$0.isOccupied ? Constants.occupied : Constants.notOccupied, maxOccupancy: $0.maxOccupancy, id: $0.id)
                }
            
                return promise(.success(rooms))
            }
            
            self.cancellables.insert(cancellable)

        }
    }
    
    deinit {
        cancellables.forEach { cancellable in
            cancellable?.cancel()
        }
    }
}
