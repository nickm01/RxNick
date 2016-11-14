import Foundation
import RxSwift

protocol TheremostatDataService {
    var thermostatObservable: Observable<Thermostat>! {get}
}

class DummySocketTheremostatDataService: TheremostatDataService {
    
    var thermostatObservable: Observable<Thermostat>!
    private let thermostatVariable: Variable<Thermostat>
    
    static let instance = DummySocketTheremostatDataService()
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
        
    }
    
    func processDataChange() {
        self.thermostatVariable.value = self.thermostatVariable.value.makeRandomChanges()
        print(self.thermostatVariable.value)
        self.simulateSocketStream()
    }
    
}
