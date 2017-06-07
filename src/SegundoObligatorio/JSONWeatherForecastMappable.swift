import Foundation
import ObjectMapper

class JSONWeatherForecastMappable: Mappable {
    var day:String=""
    var icon:String=""
    var temperature:String=""
    
    required init? (map: Map){
    }
    
    func mapping(map: Map) {
        day <- map["forecast.time.day"]
        icon <- map["forecast.symbol.var"]
        temperature <- map["forecast.temperature.day"]
    }
}
