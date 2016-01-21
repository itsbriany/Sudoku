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
}