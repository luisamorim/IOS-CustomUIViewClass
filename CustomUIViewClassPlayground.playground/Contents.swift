import UIKit
import PlaygroundSupport


public class RootViewController: UIViewController {
    
    var mainView:MainView { return self.view as! MainView }
    var liked = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.likeAction = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.liked = !strongSelf.liked
            
            if(strongSelf.liked) {
                UIView.animate(withDuration: 0.5, animations: {
                    strongSelf.mainView.likeButton.setTitle("Dislike", for: .normal)
                    strongSelf.mainView.contentView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                })
                
                
            }else {
                UIView.animate(withDuration: 0.5, animations: {
                    strongSelf.mainView.likeButton.setTitle("Like", for: .normal)
                    strongSelf.mainView.contentView.backgroundColor = .clear
                })
                
            }
        }
        
    }
    
    public override func loadView() {
        self.view = MainView(frame: UIScreen.main.bounds)
    }
}

public class MainView: UIView {
    
    var likeAction :(() -> Void)?
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupViews()
        setupConstraints()
        addActions()
    }
    
    func setupViews(){
        self.addSubview(contentView)
        self.addSubview(likeButton)
    }
    
    func addActions(){
        likeButton.addTarget(self, action: #selector(self.onLikeButton), for: .touchUpInside)
    }
    
    @objc func onLikeButton(){
        likeAction?()
    }
    
    func setupConstraints(){
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        likeButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        
    }
    
    let contentView:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Like", for: .normal)
        return button
    }()
    
}

PlaygroundPage.current.liveView = RootViewController()

