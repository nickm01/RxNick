import UIKit
import RxSwift
import RxSugar

class ExampleView: UIView {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let variableLabel3 = Variable(ExampleViewModel.initial())
    
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        print("yeah")
        self.backgroundColor = UIColor.brown
        
        self.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label1.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
        
        self.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label2.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20).isActive = true
        
        self.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label3.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        
        self.addSubview(label4)
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label4.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 80).isActive = true
        
        
        disposeBag ++ label3.rxs.text <~ variableLabel3.asObservable()
            .map{
                viewModel in
                print("RxSugar Event \(viewModel)")
                return ("Temp::\(viewModel.currentTemp)")
            }
        
        variableLabel3.asObservable().subscribe {[weak self] event in
            if let viewModel = event.element {
                self?.label4.text = "4:\(viewModel.currentTemp)"
            }
        }.addDisposableTo(disposeBag)
    }
    
    func viewModelUpdates(event: Event<ExampleViewModel>) {
        print("Eventing:\(event)")
        if let viewModel = event.element {
            label1.text = "Temp: \(viewModel.currentTemp)"
            let onlineText = viewModel.online ? "Online" : "Offline"
            label2.text = "Status \(onlineText)"
            
        }
    }
}
