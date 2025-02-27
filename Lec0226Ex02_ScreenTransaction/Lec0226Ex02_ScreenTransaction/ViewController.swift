//
//  ViewController.swift
//  Lec0226Ex02_ScreenTransaction
//
//  Created by nelime on 2/26/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Navigation View Controller 사용해서 뷰 푸쉬하기
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // 스토리보드에 있는 뷰 컨트롤러 인스턴트화 하기
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // presentation 활용해서 뷰 present하기
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") else { return }
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }
}

