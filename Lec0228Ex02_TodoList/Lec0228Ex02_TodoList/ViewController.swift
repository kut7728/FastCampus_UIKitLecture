//
//  ViewController.swift
//  Lec0228Ex02_TodoList
//
//  Created by nelime on 2/28/25.
//

import UIKit

class ViewController: UIViewController {
    //왜 얘는 weak이 아니냐! -> 편집모드가 아닐때는 버튼이 disabled되는데 그러면 메모리에서 해제되어 이후에 재사용이 불가능하기 때문
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var doneButton: UIBarButtonItem?
    
    var tasks: [Task] = [] {
        didSet {
            self.saveTasks()  // 프로퍼티 옵저버 : tasks배열에 할일이 추가될때마다 saveTasks() 메서드 실행
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // done 버튼 생성해두기
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTap))
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTasks()
    }
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = self.editButton
        self.tableView.setEditing(false, animated: true)
        
    }
    
    @IBAction func tapEditButton(_ sender: UIBarButtonItem) {
        guard !self.tasks.isEmpty else { return }  // 리스트가 비어있다면 굳이 편집모드가 필요없으니 방어코드
        self.navigationItem.leftBarButtonItem = self.doneButton // Edit버튼을 눌러 편집모드가 되면 바 아이템을 done 버튼으로 변경
        self.tableView.setEditing(true, animated: true) // 편집모드 시작
    }
    
    @IBAction func tapAddButton(_ sender: UIBarButtonItem) {
        // .alert는 팝업창, .actionSheet는 모달창같이 뜨는 목록
        let alert = UIAlertController(title: "할 일 등록", message: nil, preferredStyle: .alert)
        
        // 현재 클로저가 들어가있는 handler 파라미터는 알림창의 버튼을 눌렀을때 실행될 동작을 정의해줌
        // weak self : 두 객체가 서로를 참조하는 경우 해제되지 않는 강한 순환 참조가 일어나서 메모리 누수가 일어남
        let registerButton = UIAlertAction(title: "등록", style: .default) { [weak self] _ in
            guard let title = alert.textFields?[0].text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.tableView.reloadData()  //할일이 늘어날때마다 테이블 뷰를 갱신시키는 메서드
            
        }
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // 둘의 추가 순서는 뷰의 순서와는 무관, 무조건 취소가 왼쪽
        alert.addAction(registerButton)
        alert.addAction(cancelButton)
        
        // configurationHandler는 alert에 들어갈 textField 컴포넌트를 표현하는 클로저
        alert.addTextField { textField in
            textField.placeholder = "할 일을 입력해주세요."
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    //userDefault에 저장하기
    func saveTasks() {
        
        //userDefault에는 키-밸류 형식으로 저장
        let data = self.tasks.map {
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        let userDefaults = UserDefaults.standard  // 싱글톤 패턴의 객체를 참조
        userDefaults.set(data, forKey: "tasks") // set메서드로 (저장데이터, 키값)의 형태로 저장
    }
    
    func loadTasks() {
        let userDefaults = UserDefaults.standard // userDefault 접근
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return } //키를 통해 밸류 참조
        self.tasks = data.compactMap {  // tasks 배열에 데이터 장착
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
}

// MARK: - UITableViewDataSource

// UITableView 구현시 필수적으로 구현해야하는 두 메서드
extension ViewController: UITableViewDataSource {
    // 각 섹션에 표시할 행의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    // 특정 행을 그리기 위한 셀을 반환
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //dequeReusableCell 메서드 : 제공한 withIdentifier 식별자로 재사용 가능한 cell 뷰를 tableView의 indexPath 위치에서 사용하도록 반환해줌
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) // 스토리 보드에 구현한 셀 가져오기
        let task = self.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    // 편집모드에서 삭제버튼 눌렀을때 눌린 셀이 어떤놈인지 알려주는 메서드 & 스와이프해서 삭제 기능 구현해줌
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.tasks.remove(at: indexPath.row)  // 눌린 셀의 데이터 삭제
        tableView.deleteRows(at: [indexPath], with: .automatic) // 삭제된 셀의 인덱스를 받아서 셀 삭제
        
        // 모든 할일을 삭제했을때 자동으로 편집모드에서 탈출
        if self.tasks.isEmpty {
            self.doneButtonTap()
        }
    }
    
    // 편집모드에서 할일 순서 변경 메서드
    // 셀이 이동가능한지 알려주는 메서드... 그냥 true 반환하도록 짜면 됨;;
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 순서가 이동할 셀의 인덱스와 이동할 위치의 인덱스 알려주는 메서드
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 데이터의 배열 수정
        var tasks = self.tasks
        let task = tasks[sourceIndexPath.row]
        tasks.remove(at: sourceIndexPath.row)
        tasks.insert(task, at: destinationIndexPath.row)
        self.tasks = tasks
    }
}



// MARK: - UITableViewDelegate

// 셀을 눌렀을때 체크 표시가 나오도록 액션을 정의하기 위해 델리게이트 채택
extension ViewController: UITableViewDelegate {
    
    // 셀을 선택했을때 어떤 셀이 선택됐는지 알려주는 메서드
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var task = self.tasks[indexPath.row]
        task.done.toggle()
        self.tasks[indexPath.row] = task
        // 선택된 셀 갱신, 배열로 전체 리스트 갱신도 가능하지만 여기서는 선택된 셀만
        self.tableView.reloadRows(at: [indexPath], with: .automatic) // with: - 셀의 변동에 따른 애니메이션 설정
    }
}
