//
//  SudokuTests.swift
//  SudokuTests
//
//  Created by Brian Yip on 2016-01-14.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import XCTest
@testable import Sudoku

class SudokuTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testReadSudokuDatabase() {
        let sudokuManager: SudokuManager = SudokuManager()
        let text = sudokuManager.readSudokuDB()
        XCTAssertNotEqual(text, "Could not read sudoku database")
        XCTAssertNotEqual(text, "IO error reading database")
        XCTAssertFalse(text.isEmpty)
        XCTAssertTrue(text.containsString("8.......24...3........5..1...1...56.......9.....7........8.4..7.6....3...9.2....."))
        XCTAssertTrue(text.containsString("....7...1..6.....5......4...9....5..6.81.5..........8731..9....76..2....2..31...9"))
    }
    
    func testLoadSudokus() {
        let sudokuManager: SudokuManager = SudokuManager()
        XCTAssertGreaterThan(sudokuManager.sudokus.count, 10)
    }
    
    func testSudokuCell() {
        let sudoku: Sudoku = Sudoku(sudoku: "....7...1..6.....5......4...9....5..6.81.5..........8731..9....76..2....2..31...9")
        XCTAssertEqual(sudoku.squares?[3][0], 7)
        XCTAssertEqual(sudoku.squares?[8][8], 9)
        XCTAssertEqual(sudoku.squares?[4][8], 1)
    }
    
}
