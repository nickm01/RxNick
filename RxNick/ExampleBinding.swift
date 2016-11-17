import Foundation
import RxSwift
import RxSugar

struct ExampleBinding {
    
    static func bindView(view:ExampleView, model:ExampleModel) {
         model.exampleViewModelObservable
            .subscribe(view.viewModelUpdates)
            .addDisposableTo(view.disposeBag)
        
        view.disposeBag
            ++ view.variableLabel3 <~ model.exampleViewModelObservable
    }
}
