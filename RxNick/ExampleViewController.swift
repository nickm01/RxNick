import UIKit


class ExampleViewController: UIViewController {

    var exampleModel: ExampleModel?
    
    override func loadView() {
        self.exampleModel = ExampleModel(thermostatDataService: DummySocketTheremostatDataService.instance)
        super.loadView()
        let exampleView = ExampleView()
        self.view = exampleView
        ExampleBinding.bindView(view: exampleView, model: self.exampleModel!)
    }
}
