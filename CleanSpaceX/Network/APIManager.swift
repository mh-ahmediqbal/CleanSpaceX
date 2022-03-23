//
//  APIManager.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/18/21.
//

import PromiseKit
import Moya
import Alamofire

protocol GeneralAPI {
    static func callApi<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type, test: Bool, sslPinningEnabled: Bool, debugMode: Bool) -> Promise<U>
}


struct APIManager: GeneralAPI {
    
    /// Generic function to call API endpoints using moya and decodable protocol
    ///
    /// - Parameters:
    ///   - target: The network moya target endpoint to call
    ///   - dataReturnType: The typpe of data that is expected to parse from endpoint response
    ///   - test: Boolean that help toggle real network call or simple mock data to be returned by moya
    ///   - debugMode: Toggle the verbose mode of moya
    /// - Returns: A promise containing the dataReturnType set in function params
    static func callApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type, test: Bool = false, sslPinningEnabled : Bool = false, debugMode: Bool = false) -> Promise<ReturnedObject> {
        
        let provider = test ? (MoyaProvider<Target>(stubClosure: MoyaProvider.immediatelyStub)) :
            (debugMode ? MoyaProvider<Target>(session: sslPinningEnabled ? SSLPinningAlamofireManager.sharedManager : DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))]) : MoyaProvider<Target>(session: sslPinningEnabled ? SSLPinningAlamofireManager.sharedManager : DefaultAlamofireManager.sharedManager))
        
        return Promise { seal in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    
                    let decoder = JSONDecoder()
                    do {
                        _ = try response.filterSuccessfulStatusCodes()
                        let results = try decoder.decode(ReturnedObject.self, from: response.data)
                        seal.fulfill(results)
                    } catch {
                        seal.reject(error)
                    }
                case let .failure(error):
                    seal.reject(error)
                }
            }
        }
    }
}

class DefaultAlamofireManager: Alamofire.Session {
    
    static let sharedManager: DefaultAlamofireManager = {
        
        var policies: [String: ServerTrustManager]?
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 300 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 300 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}

class SSLPinningAlamofireManager: Alamofire.Session {
    
    static let sharedManager: DefaultAlamofireManager = {
        
        var policies: [String: ServerTrustManager]?
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 300 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 300 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        
        let evaluators = [
            "kfhbonline.com": PublicKeysTrustEvaluator(),
            "www.kfhbonline.com": PublicKeysTrustEvaluator(),
        ]
        let manager = ServerTrustManager(evaluators: evaluators)
        return DefaultAlamofireManager(configuration: configuration, serverTrustManager: manager)
    }()
}

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}
