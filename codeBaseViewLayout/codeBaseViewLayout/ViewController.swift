//
//  ViewController.swift
//  codeBaseViewLayout
//
//  Created by nelime on 3/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    var data: CountUpDownModel = CountUpDownModel(count: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = counterView
    }
  
    private lazy var counterView: CountUpDownView = {
        let view = CountUpDownView()
        view.countLabel.text = String(data.count)
        
        view.countDownButton.addTarget(self, action: #selector(decreseCount), for: .touchUpInside)
        view.countUpButton.addTarget(self, action: #selector(increseCount), for: .touchUpInside)
        return view
    }()
    
    @objc func increseCount() {
        self.data.increaseCount()
        self.updateCount()
    }
    
    @objc func decreseCount() {
        self.data.decreaseCount()
        self.updateCount()
    }
    
    private func updateCount(){
        self.counterView.countLabel.text = String(data.count)
    }

}
