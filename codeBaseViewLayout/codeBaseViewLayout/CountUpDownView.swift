import UIKit

class CountUpDownView: UIView {
    
    //코드에서 뷰를 생성하기
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addComponents()
    }
    
    //스토리보드에서 뷰의 객체를 만들고자 할때 호출하는 메서드 -> 스토리보드 안쓰니 호출되면 강종시킴
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents() {
        self.addSubview(countLabel)
        self.addSubview(countDownButton)
        self.addSubview(countUpButton)
        
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 362),
            countLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 111),
            countLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -110),
            
            countDownButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 17),
            countDownButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 93),
            
            countUpButton.topAnchor.constraint(equalTo: countLabel.bottomAnchor, constant: 17),
            countUpButton.leftAnchor.constraint(equalTo: countDownButton.rightAnchor, constant: 7)
        ])
    }
    
    //lazy - 뷰가 사용될 때 불러와서 메모리 절약
    public lazy var countLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 42, weight: .bold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var titleContainer: AttributeContainer = {
        var container = AttributeContainer()
        
        container.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        container.foregroundColor = UIColor.black
        
        return container
        
    }()
    
    public lazy var countUpButton: UIButton = {
        let btn = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        
        configuration.image = UIImage(systemName: "arrowtriangle.up.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        configuration.imagePlacement = .top
        configuration.imagePadding = 5
        
        configuration.attributedTitle = AttributedString("숫자 올리기", attributes: titleContainer)
        configuration.titleAlignment = .center
        
        btn.configuration = configuration
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    public lazy var countDownButton: UIButton = {
        let btn = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        
        configuration.image = UIImage(systemName: "arrowtriangle.down.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        configuration.imagePlacement = .top
        configuration.imagePadding = 5
        
        configuration.attributedTitle = AttributedString("숫자 내리기", attributes: titleContainer)
        configuration.titleAlignment = .center
        
        btn.configuration = configuration
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
}
