//
//  NoteCoreDataUnitTest.swift
//  GamesTempleTests
//
//  Created by Furkan Sarı on 18.12.2022.
//

import XCTest

@testable import GamesTemple
final class NoteCoreDataUnitTest: XCTestCase {
    
    var note : NoteCoreDataManager!
    override func setUpWithError() throws {
        note = NoteCoreDataManager()
    }
    
    func testSave() throws {
        let saveData = note.saveNote(rating: 5, gameImage: "", gameName: "TestGame", header: "Good", noteText: "Fantastic")
        XCTAssertEqual(saveData?.gameName, "TestGame")
        XCTAssertEqual(saveData?.gameImage, "")
        XCTAssertEqual(saveData?.header, "Good")
        XCTAssertEqual(saveData?.noteText, "Fantastic")
    }
    
    func testGetNote() throws {
        let noteData = note.getNote()
        XCTAssertEqual(noteData[0].gameName, "TestGame")
    }
}
