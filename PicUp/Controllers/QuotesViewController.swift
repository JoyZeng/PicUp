//
//  QuotesViewController.swift
//  PicUp
//
//  Created by Joy on 2018-11-28.
//  Copyright © 2018 Joy Zeng. All rights reserved.
//

import Cocoa
import Alamofire

class QuotesViewController: NSViewController {

    @IBOutlet weak var textLabel: NSTextField!
    
    let quotes = Quote.all
    
    var currentQuoteIndex: Int = 0 {
        didSet {
            updateQuote()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuoteIndex = 0
    }
    
    func updateQuote() {
        textLabel.stringValue = String(describing: quotes[currentQuoteIndex])
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

// MARK: Actions

extension QuotesViewController {
    @IBAction func previous(sender: NSButton) {
        currentQuoteIndex = (currentQuoteIndex - 1 + quotes.count) % quotes.count
    }
    
    @IBAction func next(sender: NSButton) {
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        currentQuoteIndex = (currentQuoteIndex + 1 + quotes.count) % quotes.count
    }
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
}
