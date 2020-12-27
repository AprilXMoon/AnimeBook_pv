//
//  TopData.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/18.
//

import Foundation

struct TopData: Decodable {
    let requestHash: String
    let requestCached: Bool
    let requestCacheExpiry: Int
    let topItems: [TopItem]
    
    enum CodingKeys: String, CodingKey {
        case requestHash = "request_hash"
        case requestCached = "request_cached"
        case requestCacheExpiry = "request_cache_expiry"
        case topItems = "top"
    }
}

