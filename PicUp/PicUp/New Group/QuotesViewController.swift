//
//  QuotesViewController.swift
//  PicUp
//
//  Created by Joy on 2018-11-28.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa

class QuotesViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension QuotesViewController {
    static func freshContoller() -> QuotesViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("QuotesViewController")
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? QuotesViewController else {
            fatalError("Can not find QuotesViewController")
        }
        return viewController
    }
}
