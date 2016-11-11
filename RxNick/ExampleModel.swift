import Foundation
import RxSwift

struct ExampleViewModel {
    let currentTemp: Int
    let online: Bool
    
    static func initial() -> ExampleViewModel {
        return ExampleViewModel(currentTemp: 0, online: false)
    }
}

class ExampleModel {

    let disposeBag = DisposeBag()

    let exampleViewModelObservable: Observable<ExampleViewModel>
    private let exampleViewModel: Variable<ExampleViewModel>
    private let thermostat = Variable<Thermostat>(Thermostat.initial()) //TODO: How do we not default anything?
    
    init() {
        let service = MockSocketService.instance
        self.exampleViewModel = Variable<ExampleViewModel>(ExampleViewModel.initial())
        self.exampleViewModelObservable = self.exampleViewModel.asObservable()
        service.thermostatObservable
            .map {thermostat in
                return ExampleViewModel(currentTemp: thermostat.currentTemp, online: thermostat.connected)
            }
            .subscribe {[weak self] viewModelEvent in
                if let viewModel = viewModelEvent.element {
                    self?.exampleViewModel.value = viewModel
                }
            }
            .addDisposableTo(disposeBag)
        
    }
    
    
}

