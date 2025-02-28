//
//  RoundButton.swift
//  Lec0228Ex02_Calculator
//
//  Created by nelime on 2/28/25.
//

import UIKit

@IBDesignable   //변경될 설정값을 스토리보드에서 실시간으로 볼수 있게 해주는 어노테이션
class RoundButton: UIButton {
    // @IBInspectable -> 스토리보드의 프로퍼티 설정창에서 설정 가능하도록 해줌
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }

}
