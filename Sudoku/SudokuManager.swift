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
    
    init!(format: SudokuFormat) {
        loadSudokus(format)
    }
    
    
    // MARK: Public Interface
    func loadSudokus(format: SudokuFormat) {
        let sudokuStringArray = readSudokuDB().componentsSeparatedByString("\n")
        for sudoku in sudokuStringArray {
            sudokus.append(Sudoku(sudoku: sudoku, format: format))
        }
        if (!sudokus.isEmpty) {
            setActiveSudoku(0)
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
    

}