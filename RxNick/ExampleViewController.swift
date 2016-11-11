import UIKit


class ExampleViewController: UIViewController {

    let exampleModel = ExampleModel()
    
    override func loadView() {
        super.loadView()
        let exampleView = ExampleView()
        self.view = exampleView
        ExampleBinding.bindView(view: exampleView, model: self.exampleModel)
    }
}
