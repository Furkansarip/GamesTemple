//
//  FavoriteCoreDataUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest

@testable import GamesTemple
final class FavoriteCoreDataUnitTest: XCTestCase {

    var viewModel : FavoriteCoreDataManager!
    var fetchExpectation : XCTestExpectation!
    override func setUpWithError() throws {
    viewModel = FavoriteCoreDataManager()
       
    }
    
    func testSave() throws {
        let saveData = viewModel.saveGame(gameName: "Portal 2", gameImage: "", id: "4200")
        XCTAssertEqual(saveData?.gamesId, "4200")
        
        
    }
    
    func testGetFavoriteGame() throws {
        let favGame = viewModel.getFavoriteGame()
        XCTAssertNotEqual(favGame[0].gamesId, "")
    }
    func testDelete() throws {
        let dataCount = viewModel.getFavoriteGame().count
        viewModel.deleteFavoriteGame(name: "Portal 2")
        let newDataCount = viewModel.getFavoriteGame().count
        XCTAssertNotEqual(newDataCount, dataCount)
    }

}
