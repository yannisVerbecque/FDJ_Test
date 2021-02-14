//
//  FDJ_TestTests.swift
//  FDJ_TestTests
//
//  Created by Yannis VERBECQUE on 10/02/2021.
//

import XCTest
@testable import FDJ_Test

class FDJ_TestTests: XCTestCase {

    func testNameSearch() {
        let league = League(id: "1234", name: "Ligue 1", alternateName: "Ligue Uber Eats", sport: "scoccer")
        XCTAssertFalse(league.name.contains("Liga"))
        XCTAssertTrue(league.name.contains("Ligue"))
        XCTAssertTrue(league.doesLeagueNameContain(name: "Ligue"))
        XCTAssertFalse(league.doesLeagueNameContain(name: "Liga"))
        
        let league2 = League(id: "005", name: "Liga", alternateName: "Spanish Liga", sport: "scoccer")
        XCTAssertTrue(league2.name.contains("Liga"))
        XCTAssertFalse(league2.name.contains("Ligue"))
        XCTAssertTrue(league2.doesLeagueNameContain(name: "Liga"))
        XCTAssertFalse(league2.doesLeagueNameContain(name: "Ligue"))
    }
    
    
    func testDownloadManager() {
        let urlString = "https://www.googliiie.com"
        let expectation = self.expectation(description: "Downloading")

        do {
            try DownloadManager.downloadWithURL(urlString) { (data, response, error) in
                expectation.fulfill()
                
                XCTAssertNotNil(error, "error is not nil, there is an error")
                XCTAssertNil(data)
            }
        } catch {
            
        }
        waitForExpectations(timeout: 5, handler: nil)

        
    }
}
