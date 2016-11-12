import XCTest
import RxSwift
@testable import RxNick


class ExampleModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWhenSendingThermostatAndBoundThenResultIsViewModel() {
        
        class MockThermostatDataService: TheremostatDataService {
            private(set) var thermostatObservable: Observable<Thermostat>!
            
            init(thermostat:Thermostat) {
                self.thermostatObservable = Variable(thermostat).asObservable()
            }
        }
        
        let testThermostat = Thermostat(currentTemp: 999, setPoint: 100, connected: true)
        let mockThermostatDataService = MockThermostatDataService(thermostat: testThermostat)
        let testObject = ExampleModel(thermostatDataService: mockThermostatDataService)
        testObject.bindToThermostatObservable(thermostatDataService: mockThermostatDataService)
        
        ??? Test by subscribing to testObject.exampleViewModelObservable???
        
        
    }
    

    
}
