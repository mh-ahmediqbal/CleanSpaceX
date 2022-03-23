//
//  APIConfig.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/18/21.
//

import Foundation

struct APIConfig {

    // MARK: - BaseUrl -
    static let baseUrl = "https://api.spacexdata.com"
    static let apiVersion = "v3"
    static func getBaseUrl() -> String {
        return "\(baseUrl)/\(apiVersion)"
    }

    // MARK: - Enable/disbale API Logs -
    static let debug = true

    // MARK: - API Endpoints -
    static let RocketsEndpoint = "/rockets"

    
}
