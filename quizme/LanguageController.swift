//
//  LanguageController.swift
//  quizme
//
//  Created by Ricky Yim on 26/02/2015.
//  Copyright (c) 2015 dius. All rights reserved.
//

import Foundation
import UIKit

class LanguageController: UITableViewController {
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as ViewController
        controller.language = segue.identifier!
//        println("segue identifier \(segue.identifier)")
    }
}