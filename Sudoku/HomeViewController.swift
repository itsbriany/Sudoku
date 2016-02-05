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
    
    // Trigger action that navigates to level selection
    @IBAction func selectLevel(sender: UIButton) {
        self.performSegueWithIdentifier(self.selectLevelSegue, sender: self)
    }
    
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
        }
    }
}