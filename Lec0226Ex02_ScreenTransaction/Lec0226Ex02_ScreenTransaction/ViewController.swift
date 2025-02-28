//
//  ViewController.swift
//  Lec0226Ex02_ScreenTransaction
//
//  Created by nelime on 2/26/25.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // Navigation View Controller 사용해서 뷰 푸쉬하기
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        // 스토리보드에 있는 뷰 컨트롤러 인스턴트화 하기
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }  // 이렇게 다운 캐스팅 해줘야 내부의 name 프로퍼티를 사용 가능
        viewController.name = "UiTaek"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // presentation 활용해서 뷰 present하기
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else { return }
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "UiTaek"
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController {
            viewController.name = "UiTaek"
        }
    }
    
    func sendData(name: String) {
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
    }
}

