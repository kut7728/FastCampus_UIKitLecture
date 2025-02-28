//
//  CodePresentViewController.swift
//  Lec0226Ex02_ScreenTransaction
//
//  Created by nelime on 2/26/25.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    var name: String?
    weak var delegate: SendDataDelegate?  // 델리게이트 변수 앞에는 weak을 붙여줘야 함, 강한 순환 참조 방지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }

    }
    
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "KUT")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
