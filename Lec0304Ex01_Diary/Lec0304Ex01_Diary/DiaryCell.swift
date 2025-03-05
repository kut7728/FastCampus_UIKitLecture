//
//  DiaryCell.swift
//  Lec0304Ex01_Diary
//
//  Created by nelime on 3/4/25.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // 뷰가 스토리보드에서 생성이 될때 객체의 생성을 시작하는 메서드
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.layer.cornerRadius = 3.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
    }
    
}
