import Foundation
import RxSwift

protocol TheremostatDataService {
    var thermostatObservable: Observable<Thermostat>! {get}
}

class DummySocketTheremostatDataService: TheremostatDataService {
    
    var thermostatObservable: Observable<Thermostat>!
    var thermostat = Thermostat.initial()
    //private let thermostatVariable: Variable<Thermostat>
    
    static let instance = DummySocketTheremostatDataService()
    let disposeBag = DisposeBag()
    
    init() {
        //self.thermostatVariable = Variable(Thermostat.initial())
        //self.thermostatObservable = thermostatVariable.asObservable()
        self.simulateSocketStream()
    }
    
    func simulateSocketStream() {
//        
//        Observable<Int>
//            .interval(0.2, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
//            .map { _ in
//                return self.thermostatVariable.value.makeRandomChanges()
//            }
//            .subscribe{[weak self] event in
//                if let thermostat = event.element {
//                    print("SocketService \(thermostat)")
//                    self?.thermostatVariable.value = thermostat
//                }
//            }
//            .addDisposableTo(disposeBag)
        
        //HOW DO I MAKE THIS HOT???
        self.thermostatObservable = Observable<Thermostat>.create { (observer) -> Disposable in
            DispatchQueue.global(qos: .background).async {
                // Do background work
                while true {
                    // Stop errors
                    if Int(arc4random_uniform(10)) == -1 {
                        print("------ ERROR")
                        let err:Error = NSError(domain: "Error", code: 0, userInfo: nil)
                        observer.onError(err)
                    } else {
                        self.thermostat = self.thermostat.makeRandomChanges()
                        print("SocketService \(self.thermostat)")
                        observer.onNext(self.thermostat)
                    }
                    Thread.sleep(forTimeInterval: 1)
                }
            }
        
            return Disposables.create()
        }

        
    }
//    
//    func processDataChange() {
//        self.thermostatVariable.value = self.thermostatVariable.value.makeRandomChanges()
//        print(self.thermostatVariable.value)
//        self.simulateSocketStream()
//    }
//    
}
