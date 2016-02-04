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
        let format = SudokuFormat(rows: 9, columns: 9)
        let sudokuManager: SudokuManager = SudokuManager(format: format)
        let text = sudokuManager.readSudokuDB()
        XCTAssertNotEqual(text, "Could not read sudoku database")
        XCTAssertNotEqual(text, "IO error reading database")
        XCTAssertFalse(text.isEmpty)
        XCTAssertTrue(text.containsString("8.......24...3........5..1...1...56.......9.....7........8.4..7.6....3...9.2....."))
        XCTAssertTrue(text.containsString("....7...1..6.....5......4...9....5..6.81.5..........8731..9....76..2....2..31...9"))
    }
    
    func testLoadSudokus() {
        let format = SudokuFormat(rows: 9, columns: 9)
        let sudokuManager: SudokuManager = SudokuManager(format: format)
        XCTAssertGreaterThan(sudokuManager.sudokus.count, 10)
    }
    
    func testSudokuCellMapping() {
        let format = SudokuFormat(rows: 9, columns: 9)
        let sudoku: Sudoku = Sudoku(sudoku: "....7...1..6.....5......4...9....5..6.81.5..........8731..9....76..2....2..31...9",
        format: format)
        XCTAssertEqual(sudoku.cells[0][4], 7)
        XCTAssertEqual(sudoku.cells[8][8], 9)
        XCTAssertEqual(sudoku.cells[8][3], 3)
    }
    
    func testIsValidSudoku() {
        let format = SudokuFormat(rows: 9, columns: 9)
        var sudoku: Sudoku = Sudoku(sudoku: "....7...1..6.....5......4...9....5..6.81.5..........8731..9....76..2....2..31...9",
             format: format)
        XCTAssertFalse(sudoku.isSolved())
        sudoku = Sudoku(sudoku: "294167358315489627678253491456312879983574216721698534562941783839726145147835962", format: format)
        XCTAssert(sudoku.isSolved())
        sudoku = Sudoku(sudoku: "294167358315489627678253491456312879983574216721698534562941783839726145147835961", format: format)
        XCTAssertFalse(sudoku.isSolved())
    }
    
    func testUpdateSudoku() {
        let format = SudokuFormat(rows: 9, columns: 9)
        let sudokuManager: SudokuManager = SudokuManager(format: format)
        sudokuManager.updateActiveSudoku(0, columnIndex: 0, value: 9)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][0], 9)
        sudokuManager.updateActiveSudoku(0, columnIndex: 1, value: 8)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][1], 8)
        sudokuManager.updateActiveSudoku(8, columnIndex: 8, value: 7)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[8][8], 7)
        
        // The rows and columns exceed the format, so cells[8][8] will be updated instead
        sudokuManager.updateActiveSudoku(100, columnIndex: 100, value: 6)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[8][8], 6)
    }
    
    func testResetSudoku() {
        let format = SudokuFormat(rows: 9, columns: 9)
        let sudokuManager: SudokuManager = SudokuManager(format: format)
        
        // Update the active sudoku
        sudokuManager.updateActiveSudoku(0, columnIndex: 0, value: 9)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][0], 9)
        sudokuManager.updateActiveSudoku(0, columnIndex: 1, value: 8)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][1], 8)
        
        // Reset the active sudoku
        sudokuManager.resetActiveSudoku()
        XCTAssertNotEqual(sudokuManager.activeSudoku?.cells[0][0], 9)
        XCTAssertNotEqual(sudokuManager.activeSudoku?.cells[0][1], 8)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][0], 4)
        XCTAssertEqual(sudokuManager.activeSudoku?.cells[0][1], 0)
    }
}
