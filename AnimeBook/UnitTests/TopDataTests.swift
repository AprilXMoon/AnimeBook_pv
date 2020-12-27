//
//  TopDataTests.swift
//  TopDataTests
//
//  Created by April Lee on 2020/12/18.
//

import XCTest
@testable import AnimeBook

class TopDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func getItem(fileName: String) -> TopData? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            print("[TEST]\(#function) Error: Can not find mock file")
            return nil
        }
     
        do {
            let data = try Data(contentsOf: url)
            let topData = try JSONDecoder().decode(TopData.self, from: data)
            return topData
        } catch let error {
            print("[TEST] \(#function) Error :\(error.localizedDescription)")
        }
        return nil
    }

    func testTopAmine() {
        guard let topAmineItem = getItem(fileName: "TopAmine") else {
            XCTFail("[TEST] TopAmine read fail")
            return
        }
        
        XCTAssertEqual(topAmineItem.requestHash, "request:top:6ca7f65d98ad03f12e5c0e7e6fac8e5cfea00e27")
        XCTAssertTrue(topAmineItem.requestCached)
        XCTAssertEqual(topAmineItem.requestCacheExpiry, 39190)
        
        XCTAssertEqual(topAmineItem.topItems.count, 5)
        
        XCTAssertEqual(topAmineItem.topItems[0].type, "TV")
        XCTAssertEqual(topAmineItem.topItems[3].type, "Special")
        
        XCTAssertEqual(topAmineItem.topItems[3].rank, 27)
    }
    
    func testTopManga() {
        guard let topAmineItem = getItem(fileName: "TopManga") else {
            XCTFail("[TEST] TopAmine read fail")
            return
        }
        
        XCTAssertEqual(topAmineItem.requestHash, "request:top:aa17e4b7df40054f74ed997046bd33edce2c1a03")
        XCTAssertTrue(topAmineItem.requestCached)
        XCTAssertEqual(topAmineItem.requestCacheExpiry, 64372)
        
        XCTAssertEqual(topAmineItem.topItems.count, 5)
        
        XCTAssertEqual(topAmineItem.topItems[0].type, "Manga")
        XCTAssertEqual(topAmineItem.topItems[0].score, 9.35)
        
        XCTAssertEqual(topAmineItem.topItems[4].rank, 5)
        XCTAssertEqual(topAmineItem.topItems[4].volumes, 18)
        
    }
}
