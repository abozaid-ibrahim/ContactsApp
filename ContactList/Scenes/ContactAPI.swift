//
//  ContactAPI.swift
//  ContactList
//
//  Created by abuzeid on 01.10.20.
//  Copyright © 2020 abuzeid. All rights reserved.
//

import Foundation


enum ContactAPI {
    case contactsList
}

extension ContactAPI: RequestBuilder {
    var baseURL: URL {
        return URL(string: APIConstants.baseURL)!
    }

    var path: String {
        switch self {
        case .contactsList:
            return "Contact-list-iOS-bcecc6582f774ba9b679a64a06c27802"
        }
    }

    private var endpoint: URL {
        return URL(string: "\(baseURL)\(path)")!
    }

    var method: HttpMethod {
        return .get
    }

    var parameters: [String: Any] {
        return [:]
    }

    var request: URLRequest {
        var items = [URLQueryItem]()
        var urlComponents = URLComponents(string: endpoint.absoluteString)
        for (key, value) in parameters {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents?.queryItems = items
        var request = URLRequest(url: urlComponents!.url!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        return request
    }
}
