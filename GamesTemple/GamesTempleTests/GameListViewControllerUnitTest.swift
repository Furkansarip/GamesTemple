//
//  GameListViewControllerUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest
@testable import GamesTemple
final class GameListViewControllerUnitTest: XCTestCase {

    var viewController = GamesListViewController()
    var viewModel : GameListViewModel!
    var fetchExpectation : XCTestExpectation!
    override func setUpWithError() throws {
       viewModel =  GameListViewModel()
        viewModel.delegate = self
    }

    func testPage() {
        let testPage = viewController.page
        XCTAssertNotEqual(testPage, 2)
    }
   
    func testHighest() {
        let data = viewController.filteredGames
        viewModel.getHighestRating()
        XCTAssertNotEqual(data?[0].name, "")
    }
    
    func testThisYear() {
        let data = viewController.filteredGames
        viewModel.upcomingGames()
        XCTAssertNotEqual(data?[0].name, "")
    }
    
    func testFetchGames() throws {
        let data = viewController.filteredGames
        viewModel.fetchGames(page: viewController.page)
        XCTAssertNotEqual(data?[0].name, "")
    }

}

extension GameListViewControllerUnitTest : GameListViewModelDelegate {
    func gamesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func gamesFailed(error: GamesTemple.ErrorModel) {
        print("error")
    }
    
    
}
