//
//  RoomsViewModelTests.swift
//  MacesAppTests
//
//  Created by Binal Jogi on 06/05/2022.
//

import XCTest
@testable import MacesApp

class RoomsViewModelTests: XCTestCase {

    var roomsViewModel: RoomsViewModel!
    var networkManager: MockNetworkManager!

    override func setUpWithError() throws {
        
        networkManager = MockNetworkManager()

    
        roomsViewModel = RoomsViewModel(roomsRepository: RoomsRepository(networkManager: networkManager))
    }


    func testFetchRooms_success() {

        roomsViewModel.submitAction(action: RoomsActions.loadRooms(ApiRequest(baseUrl:"roomSuccess", path:"", params: [:])))


        XCTAssertEqual(roomsViewModel.numberOfRooms, 65)

        let room =  roomsViewModel.getRoom(for: 0)

        XCTAssertNotNil(room)
        XCTAssertEqual(room.occupiedMessage, "Not Occupied")
        XCTAssertEqual(room.maxOccupancy, 53539)

        XCTAssertEqual(roomsViewModel.state,RoomsReaction.showRooms )
    }

    func testFetchSearch_failure() {


        roomsViewModel.submitAction(action: RoomsActions.loadRooms(ApiRequest(baseUrl:"roomFailure", path:"", params: [:])))

        XCTAssertEqual(roomsViewModel.numberOfRooms, 0)

    }
}
