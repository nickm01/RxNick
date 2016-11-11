import Foundation
import RxSwift

class MockSocketService {
    
    let thermostatObservable: Observable<Thermostat>
    private let thermostatVariable: Variable<Thermostat>
    
    static let instance = MockSocketService()
    let disposeBag = DisposeBag()
    
    init() {
        self.thermostatVariable = Variable(Thermostat.initial())
        self.thermostatObservable = thermostatVariable.asObservable()
        self.simulateSocketStream()
    }
    
    func simulateSocketStream() {
        
        Observable<Int>
            .interval(0.2, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .map { _ in
                return self.thermostatVariable.value.makeRandomChanges()
            }
            .subscribe{[weak self] event in
                if let thermostat = event.element {
                    print("SocketService \(thermostat)")
                    self?.thermostatVariable.value = thermostat
                }
            }
            .addDisposableTo(disposeBag)
        
        
//        let randomWait = Int(arc4random_uniform(5000))
//        print(randomWait)
//        let waittime: DispatchTime = .now() + .microseconds(randomWait)
//        DispatchQueue.global(qos: .background).asyncAfter(deadline: waittime) {[weak self] _ in
//            self?.processDataChange()
//        }
    }
    
    func processDataChange() {
        self.thermostatVariable.value = self.thermostatVariable.value.makeRandomChanges()
        print(self.thermostatVariable.value)
        self.simulateSocketStream()
    }
    
}
