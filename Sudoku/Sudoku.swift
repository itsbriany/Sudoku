//
//  Sudoku.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-20.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import Foundation

public class Sudoku {
    
    // MARK: Properties
    var format: SudokuFormat
    var cells: [[Int]]
    
    init!(sudoku: String, format: SudokuFormat) {
        self.format = format
        self.cells = [[Int]](count: format.rows, repeatedValue: [Int](count: format.columns, repeatedValue: 0))
        mapValues(sudoku)
    }
    
    // MARK: Public Interface
    /*
        Returns true if this sudoku is solved correctly
    */
    func isSolved() -> Bool {
        for row in self.cells {
            if (!self.checkColumn(row)) {
                return false
            }
            if (!self.checkRow(row)) {
                return false
            }
        }
        return true
    }
    
    // MARK: Private Interface
    private func mapValues(sudoku: String) {
        var localRows = 0
        var localColumns = 0
        for char in sudoku.characters {
            if let number = Int(String(char)) {
                cells[localRows][localColumns] = number
            }
            localColumns++
            localColumns %= format.columns
            if (localColumns == 0) {
                localRows++
            }
        }
    }
    
    private func sortIntegers(value1: Int, value2: Int) -> Bool {
        return value1 < value2
    }
    
    private func checkColumn(row: [Int]) -> Bool {
        var current: Int = 1
        var unsortedColumn: [Int] = [Int]()
        for value in row {
            unsortedColumn.append(value)
        }
        let sortedColumn = unsortedColumn.sort(sortIntegers)
        for value in sortedColumn {
            if (value < current) {
                return false
            }
            current++
        }
        return true
    }
    
    private func checkRow(row: [Int]) -> Bool {
        var current = 1
        let sortedRow = row.sort(sortIntegers)
        for value in sortedRow {
            if (value < current) {
                return false
            }
            current++
        }
        return true
    }
}