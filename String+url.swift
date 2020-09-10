//
//  String+url.swift
//  ADTFoundation
//
//  Created by robin on 2020/9/10.
//

import Foundation

// ADTApiAes: - 截取
public extension String {

    var parametersFromQueryString : [String: String]? {
           guard let url = URL.init(string: self), let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
            return queryItems.reduce(into: [String: String]()) { (result, item) in
                result[item.name] = item.value
            }
    }
}

