//
//  PeopleViewModelTests.swift
//  MacesAppTests
//
//  Created by Binal Jogi on 06/05/2022.
//

import XCTest
@testable import MacesApp

class PeopleViewModelTests: XCTestCase {

    var peoplesViewModel: PeopleViewModel!
    var networkManager: MockNetworkManager!
    
    override func setUpWithError() throws {
        
        networkManager = MockNetworkManager()
    
        peoplesViewModel = PeopleViewModel(peopleRepository: PeopleRepository(networkManager: networkManager))
    }

 
    func testFetchPeople_success() {
              
        peoplesViewModel.submitAction(action: .loadPeoples(ApiRequest(baseUrl:"peopleSuccess", path:"", params: [:])))

        
        XCTAssertEqual(peoplesViewModel.numberOfPeople, 65)
        
        let people =  peoplesViewModel.getPeople(for: 0)
        
        XCTAssertNotNil(people)
        XCTAssertEqual(people.name, "Maggie Brekke")
        XCTAssertEqual(people.poster, "https://randomuser.me/api/portraits/women/21.jpg")
        XCTAssertEqual(people.email, "Crystel.Nicolas61@hotmail.com")
        
        XCTAssertEqual(peoplesViewModel.state, PeopleReaction.showPeoples)
    }

    func testFetchPeople_failure() {

        peoplesViewModel.submitAction(action: .loadPeoples(ApiRequest(baseUrl:"peopleFailure", path:"", params: [:])))

        XCTAssertEqual(peoplesViewModel.numberOfPeople, 0)
        
    }
}
