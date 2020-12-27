//
//  TopItemTests.swift
//  UnitTests
//
//  Created by April Lee on 2020/12/18.
//

import XCTest
@testable import AnimeBook

class TopItemTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func getItem(fileName: String) -> TopItem? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            print("[TEST]\(#function) Error: Can not find mock file")
            return nil
        }
     
        do {
            let data = try Data(contentsOf: url)
            let topItem = try JSONDecoder().decode(TopItem.self, from: data)
            return topItem
        } catch let error {
            print("[TEST] \(#function) Error :\(error.localizedDescription)")
        }
        return nil
    }

    func testReadTopItem() {
        let item = getItem(fileName: "AmineItem")
        XCTAssertNotNil(item)
    }
    
    func testUpcomingAnimeItemValue() {
        
        guard let animeItem = getItem(fileName: "AmineItem") else {
            XCTFail("[TEST] AmineItem read fail")
            return
        }
        
        XCTAssertEqual(animeItem.malID, 39617)
        XCTAssertEqual(animeItem.rank, 1)
        XCTAssertEqual(animeItem.title, "Yakusoku no Neverland 2nd Season")
        XCTAssertEqual(animeItem.url, "https://myanimelist.net/anime/39617/Yakusoku_no_Neverland_2nd_Season")
        XCTAssertEqual(animeItem.imageURL, "https://cdn.myanimelist.net/images/anime/1815/110626.jpg?s=1485b2d6d4bd31622917e954db1dc9f2")
        XCTAssertEqual(animeItem.type, "TV")
        
        XCTAssertNil(animeItem.episodes)
        XCTAssertNil(animeItem.volumes)
        
        XCTAssertEqual(animeItem.startDate, "Jan 2021")
        XCTAssertNil(animeItem.endDate)
        XCTAssertEqual(animeItem.members, 228748)
        XCTAssertEqual(animeItem.score, 0)
        
    }
    
    func testAiringAnimeItemValue() {
        
        guard let animeItem = getItem(fileName: "AnimeItem2") else {
            XCTFail("[TEST] AmineItem2 read fail")
            return
        }
        
        XCTAssertEqual(animeItem.malID, 40435)
        XCTAssertEqual(animeItem.rank, 10)
        XCTAssertEqual(animeItem.title, "Mo Dao Zu Shi Q")
        XCTAssertEqual(animeItem.url, "https://myanimelist.net/anime/40435/Mo_Dao_Zu_Shi_Q")
        XCTAssertEqual(animeItem.imageURL, "https://cdn.myanimelist.net/images/anime/1748/108467.jpg?s=da2c0eac619f81ffad7da4c37dcb30b5")
        XCTAssertEqual(animeItem.type, "ONA")
        
        XCTAssertEqual(animeItem.episodes, 30)
        XCTAssertNil(animeItem.volumes)
        
        XCTAssertEqual(animeItem.startDate, "Jul 2020")
        XCTAssertEqual(animeItem.endDate, "Feb 2021")
        XCTAssertEqual(animeItem.members, 7801)
        XCTAssertEqual(animeItem.score, 7.93)
        
    }
    
    func testMangaItemValue() {
        
        guard let mangaItem = getItem(fileName: "MangaItem") else {
            XCTFail("[TEST] MangaItem read fail")
            return
        }
        
        XCTAssertEqual(mangaItem.malID, 6978)
        XCTAssertEqual(mangaItem.rank, 1)
        XCTAssertEqual(mangaItem.title, "Ginga Eiyuu Densetsu")
        XCTAssertEqual(mangaItem.url, "https://myanimelist.net/manga/6978/Ginga_Eiyuu_Densetsu")
        XCTAssertEqual(mangaItem.imageURL, "https://cdn.myanimelist.net/images/manga/5/155231.jpg?s=542b8ecfb116cf71164c5947326b41f5")
        XCTAssertEqual(mangaItem.type, "Novel")
        
        XCTAssertNil(mangaItem.episodes)
        XCTAssertEqual(mangaItem.volumes,10)
        
        XCTAssertEqual(mangaItem.startDate, "Nov 1982")
        XCTAssertEqual(mangaItem.endDate, "Nov 1987")
        XCTAssertEqual(mangaItem.members, 5559)
        XCTAssertEqual(mangaItem.score, 8.58)
        
    }
}
