import XCTest
import RxSwift
import RxTest
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
    
    func testWhenSendingSingleThermostatAndBoundThenResultIsViewModel() {
        
        class MockThermostatDataService: TheremostatDataService {
            private(set) var thermostatObservable: Observable<Thermostat>!
            var thermostatVariable = Variable(Thermostat.initial())
            init() {
                self.thermostatObservable = thermostatVariable.asObservable()
            }
        }
        
        let mockThermostatDataService = MockThermostatDataService()
        let testObject = ExampleModel(thermostatDataService: mockThermostatDataService)
        let testThermostat = Thermostat(currentTemp: 999, setPoint: 666, connected: false)
        mockThermostatDataService.thermostatVariable.value = testThermostat
        
        let expectedViewModel = ExampleViewModel(currentTemp: 999, online: false)
        
        let scheduler = TestScheduler(initialClock: 0)
        let expectedEvents = [
            next(0, expectedViewModel)
        ]
        let observer = scheduler.createObserver(ExampleViewModel.self)
        _ = testObject.exampleViewModelObservable
            .subscribe(observer)
        XCTAssertEqual(observer.events, expectedEvents)
        
    }
    
    func testWhenSendingMultipleThermostatsWithTimingsAndBoundThenResultAreCorrectlyTimedViewModel() {
        
        class MockThermostatDataService: TheremostatDataService {
            private(set) var thermostatObservable: Observable<Thermostat>!
            init(thermostatObservable: Observable<Thermostat>) {
                self.thermostatObservable = thermostatObservable
            }
        }
        let scheduler = TestScheduler(initialClock: 0)
        let xs = scheduler.createHotObservable([
            next(150, Thermostat(currentTemp: 1, setPoint: 1, connected: true)),
            next(210, Thermostat(currentTemp: 2, setPoint: 2, connected: false)),
            next(220, Thermostat(currentTemp: 3, setPoint: 3, connected: true)),
            next(230, Thermostat(currentTemp: 4, setPoint: 4, connected: false)),
            next(240, Thermostat(currentTemp: 5, setPoint: 5, connected: true)),
            ])

        let mockThermostatDataService = MockThermostatDataService(thermostatObservable: xs.asObservable())
        let testObject = ExampleModel(thermostatDataService: mockThermostatDataService)
        
        let observer = scheduler.createObserver(ExampleViewModel.self)
        _ = testObject.exampleViewModelObservable
            .subscribe(observer)
        
        _ = scheduler.start()
        
        let expectedEvents = [
            next(0, ExampleViewModel(currentTemp: 0, online: false)), //TODO: Shouldn't need this
            next(150, ExampleViewModel(currentTemp: 1, online: true)),
            next(210, ExampleViewModel(currentTemp: 2, online: false)),
            next(220, ExampleViewModel(currentTemp: 3, online: true)),
            next(230, ExampleViewModel(currentTemp: 4, online: false)),
            next(240, ExampleViewModel(currentTemp: 5, online: true)),
        ]

        XCTAssertEqual(observer.events, expectedEvents)
        
    }

    
}
