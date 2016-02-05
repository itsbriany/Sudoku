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
        sudokuManager = SudokuManager(format: self.format)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Pass data to the destination view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.selectLevelSegue {
            if let destination = segue.destinationViewController as? LevelViewController {
                destination.sudokuManager = self.sudokuManager
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