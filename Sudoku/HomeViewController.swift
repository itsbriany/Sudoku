//
//  ViewController.swift
//  Sudoku
//
//  Created by Brian Yip on 2016-01-14.
//  Copyright © 2016 Brian Yip. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var sudokuManager: SudokuManager?
    let format = SudokuFormat(rows: 9, columns: 9)
    let selectLevelSegue = "SelectLevelSegue"
    let startSudokuSegue = "StartSudokuSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The sudoku manager is passed around different view controllers
        // This maintains the state of the sudoku manager via the app's lifetime
        if sudokuManager == nil {
            sudokuManager = SudokuManager(format: self.format)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Navigation
    // Pass data to the destination view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.selectLevelSegue {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? LevelViewController {
                    destination.sudokuManager = self.sudokuManager
                }
            }
        } else if segue.identifier == self.startSudokuSegue {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let destination = navigationController.topViewController as? SudokuViewController {
                    destination.sudokuManager = self.sudokuManager
                }
            }
        }
    }
}