//
//  APIManager.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/18.
//

import Foundation
import Alamofire

enum AnimeSubtype: String, CaseIterable {
    case airing = "airing"
    case upcoming = "upcoming"
    case tv = "tv"
    case movie = "movie"
    case ova = "ova"
    case special = "special"
    case bypopularity = "bypopularity"
    case favorite = "favorite"
}

enum MangaSubtype: String, CaseIterable {
    case manga = "manga"
    case novels = "novels"
    case oneshots = "oneshots"
    case doujin = "doujin"
    case manhwa = "manhwa"
    case manhua = "manhua"
    case bypopularity = "bypopularity"
    case favorite = "favorite"
}

struct APIInfo {
    static let jikanHost = "https://api.jikan.moe/v3"
    static let top = "top"
}

enum APIError: Error {
    case invalidJSON
}

protocol APIProtocol {
    func fetchTopAnimeData(page: Int, subtype: AnimeSubtype, completion: @escaping (Swift.Result<TopData, Error>) -> ())
    func fetchTopMangaData(page: Int, subtype: MangaSubtype, completion: @escaping (Swift.Result<TopData, Error>) -> ())
}

extension APIProtocol {
    
    private func fetchTopData(url: String, completion: @escaping (Swift.Result<TopData, Error>) -> ()) {
        AF.request(url, method: .get).responseJSON { (response) in
            switch response.result {
            case .success:
                if let jsonData = response.value {
                    guard let data = try? JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted) else {
                        completion(.failure(APIError.invalidJSON))
                        return
                    }
                    
                    do {
                        let topData = try JSONDecoder().decode(TopData.self, from: data)
                        completion(.success(topData))
                    } catch {
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopAnimeData(page: Int, subtype: AnimeSubtype, completion: @escaping (Swift.Result<TopData, Error>) -> ()) {
        
        let url = "\(APIInfo.jikanHost)/\(APIInfo.top)/anime/\(page)/\(subtype)"
        fetchTopData(url: url) { (result) in
            completion(result)
        }
        
    }
    
    func fetchTopMangaData(page: Int, subtype: MangaSubtype, completion: @escaping (Swift.Result<TopData, Error>) -> ()) {
        let url = "\(APIInfo.jikanHost)/\(APIInfo.top)/manga/\(page)/\(subtype)"
        fetchTopData(url: url) { (result) in
            completion(result)
        }
    }
}
