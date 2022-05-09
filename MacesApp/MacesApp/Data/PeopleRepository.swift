//
//  PeopleRepository.swift
//  MacesApp
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation
import Combine

protocol PeopleRepositoryType {
    func getPeople(apiRequest:ApiRequestType)->Future<[People], ServiceError>
}

class PeopleRepository: PeopleRepositoryType {
    
    let networkManager: Networkable
    
    var cancellables:Set<AnyCancellable?> = Set()
    
    init(networkManager:Networkable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getPeople(apiRequest: ApiRequestType) -> Future<[People], ServiceError> {
        
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
                guard let decodedResponse = try? JSONDecoder().decode([PeopleData].self, from: data) else {
                    return promise(.failure(ServiceError.parsingError))
                }
                
                let peoples = decodedResponse.map {
                    People(name: "\($0.firstName ) \($0.lastName ?? "")" , email: $0.email ?? "", jobTitle: $0.jobTitle ?? "", poster: $0.avatar ?? "")
                }
                
                return promise(.success(peoples))
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
