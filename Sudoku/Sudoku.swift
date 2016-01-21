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
    let rows = 9
    let columns = 9
    var squares: [[Int]]?
    
    init!(sudoku: String) {
        squares = [[Int]](count: columns, repeatedValue: [Int](count: rows, repeatedValue: 0))
        loadSudoku(sudoku)
    }
    
    private func loadSudoku(sudoku: String) {
        var localRows = 0
        var localColumns = 0
        for char in sudoku.characters {
            if let number = Int(String(char)) {
                squares![localColumns][localRows] = number
            }
            localColumns++
            localColumns %= columns
            if (localRows != 0 && localColumns % columns == 0) {
                localRows++
            }
        }
    }
}