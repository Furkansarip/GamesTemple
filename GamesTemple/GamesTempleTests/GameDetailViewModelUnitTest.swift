//
//  GameDetailViewModelUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest

@testable import GamesTemple
final class GameDetailViewModelUnitTest: XCTestCase {

  
        var viewModel : GameDetailViewModel!
        var fetchExpectation : XCTestExpectation!
        override func setUpWithError() throws {
            
            viewModel = GameDetailViewModel()
            viewModel.delegate = self
            fetchExpectation = expectation(description: "fetchGameDetail")
        }
    
        func testGetGameID() throws {
        
        XCTAssertEqual(viewModel.gameID(), 0)
        viewModel.fetchGame(id: 3498)
        waitForExpectations(timeout: 15,handler: nil)
        let itemAtZero = viewModel.gameID()
        XCTAssertEqual(itemAtZero, 3498)
    }


}

extension GameDetailViewModelUnitTest : GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gameDetailFail(error: GamesTemple.ErrorModel) {
        print("error")
    }
    
    
}
