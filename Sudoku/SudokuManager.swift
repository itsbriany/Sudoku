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
    let solutionDatabaseFileName = "SolutionDB"
    var sudokus: [Sudoku] = [Sudoku]()
    var activeSudoku: Sudoku?
    var format: SudokuFormat?
    var sudokuIndex: Int = 0
    var solutions: [Sudoku] = [Sudoku]()
    
    // MARK: Public Interface
    init!(format: SudokuFormat) {
        self.format = format
        loadSudokus()
        loadSolutions()
    }
    
    /*
        Loads a textfile of sudokus into the app
        @param format The sudoku's format (i.e. rows and columns)
    */
    func loadSudokus() {
        let sudokuStringArray = readDB(self.sudokuDatabaseFileName).componentsSeparatedByString("\n")
        for sudoku in sudokuStringArray {
            sudokus.append(Sudoku(sudoku: sudoku, format: self.format!))
        }
        if (!sudokus.isEmpty) {
            setActiveSudoku(self.sudokuIndex)
        }
    }
    
    /*
        Sets the active sudoku from the loaded sudokus
        @param index The index representing the sudoku to choose
    */
    func setActiveSudoku(index: Int) -> Bool {
        if (index >= sudokus.count) {
            return false
        }
        activeSudoku = sudokus[index]
        return true
    }
    
    /*
        Loads a sudoku value into a cell in the UI
        @param indexPath The indexpath representing the cell
        @param cell The cell itself
        @param firstLoad This should be true if this is the first time loading the numbers into the cells
    */
    func loadSudokuValueIntoCell(indexPath: NSIndexPath, cell: SudokuCollectionViewCell, firstLoad: Bool) {
        let row = indexPath.row / (activeSudoku?.format.rows)!
        let column = indexPath.row % (activeSudoku?.format.columns)!
        let cellValue = String(activeSudoku!.cells[row][column])
        if (cellValue == "0") {
            cell.value.text = ""
        } else if (cellValue != "0" && firstLoad) {
            cell.value.text = cellValue
            cell.value.font = UIFont.boldSystemFontOfSize(17.0)
            cell.layer.borderWidth = 2.0
            cell.userInteractionEnabled = false
        } else {
            cell.value.text = cellValue

        }
    }
    
    /*
        Reads a file and dumps its contents to a string
        @param file The name of the file to read
    */
    func readDB(file: String) -> String {
        let readError = "Could not read database"
        let ioError = "IO error reading database"
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "")
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
    
    /*
        Resets the sudoku to its initial state
    */
    func resetActiveSudoku() {
        let sudokuStringArray = readDB(self.sudokuDatabaseFileName).componentsSeparatedByString("\n")
        self.activeSudoku = Sudoku(sudoku: sudokuStringArray[self.sudokuIndex], format: self.format!)
    }
    
    /*
        Solves the active sudoku
    */
    func solveActiveSudoku() {
        self.activeSudoku = solutions[self.sudokuIndex]
    }

    // MARK: Private Interface
    private func loadSolutions() {
        let solutionStringArray = readDB(self.solutionDatabaseFileName).componentsSeparatedByString("\n")
        for solution in solutionStringArray {
            solutions.append(Sudoku(sudoku: solution, format: self.format!))
        }
    }
}