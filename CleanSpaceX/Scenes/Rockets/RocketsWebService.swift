//
//  RocketsWebservice.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/18/21.
//

import Foundation
import PromiseKit

protocol RocketsWebSeriveProtocol {
    func fetchRockets(request: Rockets.SpaceX.Request) -> Promise<[Rocket]>
}

class RocketsWebService : RocketsWebSeriveProtocol {
    func fetchRockets(request: Rockets.SpaceX.Request) -> Promise<[Rocket]> {
        let target = APIService.fetchRockets
        let rocketsData = APIManager.callApi(target, dataReturnType: [Rocket].self, test: request.test, sslPinningEnabled: request.sslPinningEnabled, debugMode: APIConfig.debug)
        return rocketsData
    }
}
