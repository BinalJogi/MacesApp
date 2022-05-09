//
//  MockNetworkManager.swift
//  MacesAppTests
//
//  Created by Binal Jogi on 06/05/2022.
//

import Foundation
import Combine
@testable import MacesApp

class MockNetworkManager: Networkable {

    func doApiCall(apiRequest: ApiRequestType) -> Future<Data, ServiceError> {
        return Future { promise in
            let bundle = Bundle(for:MockNetworkManager.self)
            
            if apiRequest.baseUrl == "file_not_found_status_code_404" {
                promise(.failure(ServiceError.dataNotFound))
                return
            }
            if apiRequest.baseUrl == "internal_server_error_status_code_500" {
                promise(.failure(ServiceError.networkNotAvailable))
                return
            }
            guard let url = bundle.url(forResource: apiRequest.baseUrl, withExtension:"json"),
                  let data = try? Data(contentsOf: url) else {
                      promise(.failure(ServiceError.networkNotAvailable))
                      return
                  }
            promise(.success(data))
        }
    }
}
