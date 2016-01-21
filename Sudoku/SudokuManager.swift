//
//  SudokuManager.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-20.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import Foundation

public class SudokuManager {
    
    // MARK: Properties
    let sudokuDatabaseFileName = "SudokuDB"
    var sudokus: [Sudoku] = [Sudoku]()
    
    init!() {
        loadSudokus()
    }
    
    
    // MARK: Public Interface
    func readSudokuDB() -> String {
        let readError = "Could not read sudoku database"
        let ioError = "IO error reading database"
        let path = NSBundle.mainBundle().pathForResource(sudokuDatabaseFileName, ofType: "")
        
        do {
            if let fileContents: NSString = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding) {
                return fileContents as String
            }
        } catch {
            return ioError
        }
        return readError
    }
    
    func loadSudokus() {
        let sudokuStringArray = readSudokuDB().componentsSeparatedByString("\n")
        for sudoku in sudokuStringArray {
            sudokus.append(Sudoku(sudoku: sudoku))
        }
    }
    
    func getSudokus() -> [Sudoku] {
        return sudokus
    }
    
}