import UIKit
import RxSwift

class ExampleView: UIView {
    
    let label1 = UILabel()
    let label2 = UILabel()

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
