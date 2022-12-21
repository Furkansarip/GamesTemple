//
//  NotesViewModelUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest
@testable import GamesTemple
final class NotesViewModelUnitTest: XCTestCase {

    var viewModel : NotesViewModel!
    var fetchExpectation : XCTestExpectation!
    override func setUpWithError() throws {
        viewModel = NotesViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "favoriteViewModel")
    }
    
    func testGetNotes() throws {
        viewModel.fecthGames()
        waitForExpectations(timeout: 10)
        let data = viewModel.games
        XCTAssertNotEqual(data?[0].name, "")
    }

   
}

extension NotesViewModelUnitTest : NotesViewDelegate {
    func noteLoaded() {
        fetchExpectation.fulfill()
    }
    
    func noteFailed(error: GamesTemple.ErrorModel) {
        print(error.rawValue)
    }
    
    
}
