//
//  WriteDiaryViewController.swift
//  Lec0304Ex01_Diary
//
//  Created by nelime on 3/4/25.
//

import UIKit

protocol WriteDiaryViewDelegate: AnyObject {
    func didSelectRegister(diary: Diary)
}

class WriteDiaryViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    
    // 날짜 픽커 객체 선언
    private let datePicker = UIDatePicker()
    private var diaryDate: Date?
    weak var delegate: WriteDiaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트뷰 테두리 만들기
        self.configureContentsTextView()
        // 날짜 픽커 설정 및 텍스트필드 눌렀을때 나오도록 설정
        self.configureDatePicker()
        // 등록버튼을 기본적으로 비활성화
        self.confirmButton.isEnabled = false
        // 텍스트 필드 값변화시 등록버튼 활성화 여부 검사
        self.configureInputField()
    }
    
    // 텍스트뷰 테두리 설정
    private func configureContentsTextView() {
        let borderColor = UIColor(red: 220/225, green: 220/225, blue: 220/225, alpha: 1)
        self.contentsTextView.layer.borderColor = borderColor.cgColor  // layer관련 색상 설정은 cgColor를 사용
        self.contentsTextView.layer.borderWidth = 3
        self.contentsTextView.layer.cornerRadius = 5.0
    }
    
    // 날짜 픽커 설정
    private func configureDatePicker() {
        self.datePicker.datePickerMode = .date
        self.datePicker.preferredDatePickerStyle = .wheels
        /// addTarget : ui컨트롤러가 이벤트에 응답하는 방식을 설정
        /// self : 해당 이벤트를 처리할 객체 -> 지금은 self 뷰모델
        /// action : 이벤트에 응답하여 실행될 메서드
        /// for : 어떤 이벤트가 일어났을때 action을 실행할지
        self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
        self.datePicker.locale = Locale(identifier: "ko_KR")
        self.dateTextField.inputView = self.datePicker  // textField 선택시 datePicker 띄움
    }
    
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일(EEEEE)"
        formatter.locale = Locale(identifier: "ko_KR")
        
        self.diaryDate = datePicker.date
        self.dateTextField.text = formatter.string(from: datePicker.date)
        // 날짜 선택의 경우에는 textField로 편집하는게 아니기 때문에 날짜픽커의 값 변경시에 액션을 따로 날려줘야 함
        self.dateTextField.sendActions(for: .editingChanged)
    }
    
    // 유저가 화면 터치시 호출되는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)  // 키보드 혹은 datePicker 내리기
    }
    
    
    
    private func configureInputField() {
        self.contentsTextView.delegate = self
        /// selector에서는 파라미터 이름 필요없음, 그저 파라미터 갯수로 구분하고
        /// 파라미터가 없다면 괄호가 아예 필요없고, 있다면 (_: ) 로 갯수 구분
        self.titleTextField.addTarget(self, action: #selector(titleTextFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(dateTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc private func titleTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    @objc private func dateTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    
    
    @IBAction func tapConfirmButton(_ sender: UIBarButtonItem) {
        guard let title = self.titleTextField.text else {return}
        guard let contents = self.contentsTextView.text else {return}
        guard let date = self.diaryDate else {return}
        let diary = Diary(title: title, contents: contents, date: date, isStar: false)
        
        self.delegate?.didSelectRegister(diary: diary)
        self.navigationController?.popViewController(animated: true)
    }
    
    // 모든 입력파트가 채워져있으면 등록버튼 활성화
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.titleTextField.text?.isEmpty ?? true) && !(self.dateTextField.text?.isEmpty ?? true) && !(self.contentsTextView.text?.isEmpty ?? true)
    }
}




extension WriteDiaryViewController: UITextViewDelegate {
    
    // textView의 변화를 감지하여 코드 호출하는 메서드
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}
