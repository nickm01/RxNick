import Foundation

struct Thermostat {
    let currentTemp: Int
    let setPoint: Int
    let connected: Bool
    
    func makeRandomChanges() -> Thermostat {
        var newCurrentTemp: Int = self.currentTemp
        newCurrentTemp += Int(arc4random_uniform(7)) - 3
        let newOnline = Int(arc4random_uniform(3)) == 0 ? !self.connected :self.connected
        return Thermostat(currentTemp: newCurrentTemp, setPoint: self.setPoint, connected: newOnline)
    }
    
    static func initial() -> Thermostat {
        return Thermostat(currentTemp: 60, setPoint: 65, connected: true)
    }
}
