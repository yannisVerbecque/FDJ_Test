//
//  LeagueManagerTests.swift
//  FDJ_TestTests
//
//  Created by Yannis VERBECQUE on 13/02/2021.
//

import XCTest
@testable import FDJ_Test

class LeagueManagerTests: XCTestCase {
    
    func testGetLeagues() {
        let leagueManager = LeagueManager()
        XCTAssertEqual(leagueManager.leagues.count, 0)
        measure {
            leagueManager.refreshLeagues { (isSuccess) in
                if isSuccess {
                    XCTAssertTrue(leagueManager.leagues.count > 0)
                } else {
                    XCTAssertEqual(leagueManager.leagues.count, 0)
                }
            }
        }
    }
    
}
