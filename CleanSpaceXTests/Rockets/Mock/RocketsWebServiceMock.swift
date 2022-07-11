//
//  RocketsWebServiceMock.swift
//  CleanSpaceXTests
//
//  Created by Ahmed Iqbal on 7/2/22.
//

import Foundation
import PromiseKit

@testable import CleanSpaceX

class RocketsWebServiceMock: RocketsWebSeriveProtocol {
    
    var isGetRocketsLookupCalled = false
    
    func fetchRockets(request: Rockets.SpaceX.Request) -> Promise<[Rocket]> {
        isGetRocketsLookupCalled = true
        let target = APIService.fetchRockets
        return APIManager.callApi(target, dataReturnType: [Rocket].self, test: request.test, sslPinningEnabled: request.sslPinningEnabled, debugMode: APIConfig.debug)
    }
}
