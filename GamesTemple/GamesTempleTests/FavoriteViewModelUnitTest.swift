//
//  FavoriteViewModelUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest
@testable import GamesTemple
final class FavoriteViewModelUnitTest: XCTestCase {

    var viewModel : FavoriteViewModel!
    var fetchExpectation : XCTestExpectation!
    override func setUpWithError() throws {
        viewModel = FavoriteViewModel()
        viewModel.delegate = self
        
        fetchExpectation = expectation(description: "favoriteViewModel")
    }

    func testImages() throws {
        viewModel.getImages(gameID: 3498)
        waitForExpectations(timeout: 15)
        let imageData = viewModel.images
        XCTAssertNotEqual(imageData[0].image, "")
        
    }
  
}

extension FavoriteViewModelUnitTest : FavoriteViewDelegate {
    func favoriteImagesLoaded() {
        fetchExpectation.fulfill()
    }
    
    func favoriteImagesFailed(error: GamesTemple.ErrorModel) {
        print(error.rawValue)
    }
    
    
}
