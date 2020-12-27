//
//  TopItem.swift
//  AnimeBook
//
//  Created by April lee on 2020/12/18.
//

import Foundation

struct TopItem: Decodable {
    let malID: Int
    let rank: Int
    let title: String
    let url: String
    let type: String
    let volumes: Int?
    let episodes: Int?
    let startDate: String?
    let endDate: String?
    let members: Int
    let score: Double
    let imageURL: String
    
    var isFavorited: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case malID = "mal_id"
        case rank
        case title
        case url
        case type
        case volumes
        case episodes
        case startDate = "start_date"
        case endDate = "end_date"
        case members
        case score
        case imageURL = "image_url"
    }
}
