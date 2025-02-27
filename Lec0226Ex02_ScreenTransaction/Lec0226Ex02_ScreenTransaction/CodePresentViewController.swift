//
//  CodePresentViewController.swift
//  Lec0226Ex02_ScreenTransaction
//
//  Created by nelime on 2/26/25.
//

import UIKit

class CodePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
