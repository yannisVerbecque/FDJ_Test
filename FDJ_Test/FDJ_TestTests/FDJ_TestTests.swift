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
        let league = League(id: "", name: "Ligue 1", alternateName: "Ligue Uber Eats", sport: "")
        league.doesLeagueNameContain(name: <#T##String#>)
    }
}
