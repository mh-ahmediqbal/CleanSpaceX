//
//  APIService.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/18/21.
//

import Foundation
import Moya

// MARK: - APIService

enum APIService {
    
    // MARK: - Fetch Rockets -
    case fetchRockets(request: Rockets.SpaceX.Request)
}

extension APIService : TargetType {
    
    var baseURL: URL {
        
        switch self {
        
        case .fetchRockets:
            guard let url = URL(string: APIConfig.getBaseUrl()) else { fatalError("baseURL could not be configured.")}
            return url
        }
    }
    
    var path: String {
        
        switch self {
            
        case .fetchRockets:
            return APIConfig.RocketsEndpoint
            
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .fetchRockets:
            return .get
            
        }
    }
    
    var sampleData: Data {
        
        switch self {
        case .fetchRockets:
            return stubbedResponse("rockets")
        }    }
    
    var task: Task {
        
        switch self {
        
        case .fetchRockets(_):
            // you can modify it based on your use case
            let params: [String: Any] = [:]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        switch self {
        case .fetchRockets:
            return ["Content-Type" : "application/json", "accept" : "application/json"]
        }
    }
    
    func stubbedResponse(_ filename: String) -> Data! {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { fatalError("path could not be found") }
        return (try? Data(contentsOf: URL(fileURLWithPath: path)))
    }
}
