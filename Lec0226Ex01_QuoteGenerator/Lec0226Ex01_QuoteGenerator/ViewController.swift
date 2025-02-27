//
//  ViewController.swift
//  Lec0226Ex01_QuoteGenerator
//
//  Created by nelime on 2/26/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let quote = [
        Quote(contents: "명언1", name: "의택1"),
        Quote(contents: "명언2", name: "의택2"),
        Quote(contents: "명언3", name: "의택3"),
        Quote(contents: "명언4", name: "의택4"),
        Quote(contents: "명언5", name: "의택5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQuoteGeneratorButton(_ sender: UIButton) {
        let random = Int(arc4random_uniform(5)) // 0~4 사이의 난수 생성
        let quote = self.quote[random]
        self.quoteLabel.text = quote.contents
        self.nameLabel.text = quote.name
    }
    
}

