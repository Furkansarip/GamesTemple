//
//  GameListViewModel.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest
@testable import GamesTemple

final class GameListViewModelUnitTest: XCTestCase {

    var viewModel : GameListViewModel!
    var fetchExpectation : XCTestExpectation!
    override func setUpWithError() throws {
        
        viewModel = GameListViewModel()
        viewModel.delegate = self
        fetchExpectation = expectation(description: "fetchAllGames")
    }

   

    func testGetGameCount() throws {
        XCTAssertEqual(viewModel.getGameCount(), 0)
        viewModel.fetchGames(page: 1)
        waitForExpectations(timeout: 15,handler: nil)
        
        XCTAssertEqual(viewModel.getGameCount(), 20)
    }
    
    func testGetGameId() throws {
        XCTAssertNil(viewModel.getGameId(at: 0))
        viewModel.fetchGames(page: 1)
        waitForExpectations(timeout: 15,handler: nil)
        let itemAtZero = viewModel.getGameId(at: 0)
        XCTAssertEqual(itemAtZero, 3498)
    }
    
    func testGetGame() throws {
        
        XCTAssertNil(viewModel.getGame(at: 0))
        viewModel.fetchGames(page: 1)
        waitForExpectations(timeout: 15,handler: nil)
        let getGameItem = viewModel.getGame(at: 0)
        XCTAssertEqual(getGameItem?.id, 3498)
        XCTAssertEqual(getGameItem?.rating, 4.47)
        XCTAssertEqual(getGameItem?.released, "2013-09-17")
    }
    
    func testFetchGames() throws {
       // XCTAssertNil(viewModel.fetchGames(page: 2))
        viewModel.fetchGames(page: 2)
        waitForExpectations(timeout: 15)
        let allGames = viewModel.games
        XCTAssertEqual(allGames?[0].id, 3939)
    }
    
    func testGetHighestRating() throws {
        viewModel.getHighestRating()
        waitForExpectations(timeout: 10)
        let data = viewModel.games
        XCTAssertEqual(data?[0].id, 18050)
    }
    
    func testThisYearGames() throws {
        viewModel.upcomingGames()
        waitForExpectations(timeout: 10)
        let data = viewModel.games
        XCTAssertEqual(data?[0].id, 326243)
    }
    
}

extension GameListViewModelUnitTest : GameListViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gamesFailed(error: GamesTemple.ErrorModel) {
        print("error")
    }
    
    
}
