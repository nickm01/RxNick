import Foundation
import RxSwift

struct ExampleBinding {
    
    static func bindView(view:ExampleView, model:ExampleModel) {
         model.exampleViewModelObservable
            .observeOn(MainScheduler.instance)
            .subscribe(view.viewModelUpdates)
            .addDisposableTo(model.disposeBag)
    }
}
