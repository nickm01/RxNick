import Foundation
import RxSwift

struct ExampleViewModel {
    let currentTemp: Int
    let online: Bool
    
    static func initial() -> ExampleViewModel {
        return ExampleViewModel(currentTemp: 0, online: false)
    }
}

extension ExampleViewModel: Equatable {}

func ==(lhs: ExampleViewModel, rhs: ExampleViewModel) -> Bool {
    return lhs.currentTemp == rhs.currentTemp &&
        lhs.online == rhs.online
}

class ExampleModel {

    let disposeBag = DisposeBag()

    let exampleViewModelObservable: Observable<ExampleViewModel>
    private let exampleViewModel: Variable<ExampleViewModel>
    private let thermostat = Variable<Thermostat>(Thermostat.initial()) //TODO: How do we not default anything?
    
    init(thermostatDataService: TheremostatDataService) {
        self.exampleViewModel = Variable<ExampleViewModel>(ExampleViewModel.initial())
        self.exampleViewModelObservable = self.exampleViewModel.asObservable()
        self.bindToThermostatObservable(thermostatDataService: thermostatDataService)
        
    }
    
    func bindToThermostatObservable(thermostatDataService: TheremostatDataService) {
        thermostatDataService.thermostatObservable
            .catchErrorJustReturn(Thermostat.initial())
            .map {thermostat in
                return ExampleViewModel(currentTemp: thermostat.currentTemp, online: thermostat.connected)
            }
            .do(onNext: {_ in print("next")}, onError: nil, onCompleted: nil, onSubscribe: nil, onDispose: nil)
            .subscribe {[weak self] viewModelEvent in
                if let error = viewModelEvent.error {
                    print("**** ERROR RECEIVED **** \(error)")
                    print("**** REBINDING ****")
                    //self?.bindToThermostatObservable(thermostatDataService: thermostatDataService)

                } else if let viewModel = viewModelEvent.element {
                    self?.exampleViewModel.value = viewModel
                }
            }
            .addDisposableTo(disposeBag)
    }
    
}

