//
//  ViewController.swift
//  Lec0228Ex01_LedBoard
//
//  Created by nelime on 2/28/25.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {
    // 델리게이트로 설정뷰에서 데이터 받아오는
    func changedSetting(text: String, textColor: UIColor, backgroundColor: UIColor) {
        self.ContentsLabel.text = text
        self.ContentsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor
    }
    
    @IBOutlet weak var ContentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 왜 옵셔널 체이닝? -> IBOutlet 변수는 기본적으로 nil상태
        /// 다른 뷰로 넘어가면서 ViewController가 해제되고 ContentsLabel역시 nil이 되버림
        self.ContentsLabel?.textColor = .yellow
    }
    
    // segue를 실행하기 전에 호출되는 메서드, 루트뷰를 설정뷰의 델리게이트 객체로 설정 & 루트뷰->설정뷰 데이터 이동을 위한 메서드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // segue.destination은 스토리보드의 목표 뷰. 즉, 설정 뷰
        if let settingViewController = segue.destination as? SettingViewController {  // 설정뷰를 다운캐스팅 (프로퍼티를 사용하기 위해)
            settingViewController.delegate = self  // 루트뷰를 설정뷰의 델리게이트 객체로 설정
            
            // 루트뷰의 속성값들을 설정뷰로 넘겨주는 절차
            settingViewController.ledText = self.ContentsLabel?.text
            settingViewController.textColor = self.ContentsLabel?.textColor ?? .yellow
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }


}

