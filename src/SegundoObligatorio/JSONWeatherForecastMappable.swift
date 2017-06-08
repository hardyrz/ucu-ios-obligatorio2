import Foundation
import ObjectMapper

class JSONWeatherForecastMappable: Mappable {
    var iconId:Int = 0
    var iconString:String = ""
    var temperature:Double = 0.0
    
    required init? (map: Map){
    }
    
    func mapping(map: Map) {
        iconId      <- map["weather.0.id"]
        iconString  <- map["weather.0.icon"]
        temperature <- map["temp.day"]
    }
}

