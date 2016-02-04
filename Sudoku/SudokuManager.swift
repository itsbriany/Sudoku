//
//  SudokuManager.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-20.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import Foundation
import UIKit

public class SudokuManager {
    
    // MARK: Properties
    let sudokuDatabaseFileName = "SudokuDB"
    var sudokus: [Sudoku] = [Sudoku]()
    var activeSudoku: Sudoku?
    var format: SudokuFormat?
    var sudokuIndex: Int = 0
    
    init!(format: SudokuFormat) {
        self.format = format
        loadSudokus()
    }
    
    
    // MARK: Public Interface
    /*
        Loads a textfile of sudokus into the app
        @param format The sudoku's format (i.e. rows and columns)
    */
    func loadSudokus() {
        let sudokuStringArray = readSudokuDB().componentsSeparatedByString("\n")
        for sudoku in sudokuStringArray {
            sudokus.append(Sudoku(sudoku: sudoku, format: self.format!))
        }
        if (!sudokus.isEmpty) {
            setActiveSudoku(self.sudokuIndex)
        }
    }
    
    func setActiveSudoku(index: Int) -> Bool {
        if (index >= sudokus.count) {
            return false
        }
        activeSudoku = sudokus[index]
        return true
    }
    
    func loadSudokuValueIntoCell(indexPath: NSIndexPath, cell: SudokuCollectionViewCell) {
        let row = indexPath.row / (activeSudoku?.format.rows)!
        let column = indexPath.row % (activeSudoku?.format.columns)!
        let cellValue = String(activeSudoku!.cells[row][column])
        if (cellValue != "0") {
            cell.value.text = cellValue
            cell.value.font = UIFont.boldSystemFontOfSize(17.0)
            cell.layer.borderWidth = 2.0
            cell.userInteractionEnabled = false
            return
        }
        cell.value.text = ""
    }
    
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
    
    /**
        Updates the active sudoku using the selected row and column as an index
        @param rowIndex The row index
        @param columnIndex The column index
        @param value The value to be inserted at activeSudoku[|rowIndex|][|columnIndex|]
    */
    func updateActiveSudoku(var rowIndex: Int, var columnIndex: Int, value: Int) {
        if (rowIndex >= self.format!.rows) {
            rowIndex = self.format!.rows - 1
        }
        if (columnIndex >= self.format!.columns) {
            columnIndex = self.format!.columns - 1
        }
        self.activeSudoku!.cells[rowIndex][columnIndex] = value
    }
    
    func resetActiveSudoku() {
        let sudokuStringArray = readSudokuDB().componentsSeparatedByString("\n")
        self.activeSudoku = Sudoku(sudoku: sudokuStringArray[self.sudokuIndex], format: self.format!)
    }

}