import Foundation
import ObjectMapper

class JSONWeatherMappable: Mappable {
    var name:String=""
    var iconId:Int=0
    var iconString:String=""
    var temperature:Int=0
    required init? (map: Map){
    }
    
    init? () {
        
    }
    func mapping(map: Map) {
        name        <- map["name"]
        iconId      <- map["weather.0.id"]
        iconString  <- map["weather.0.icon"]
        temperature <- map["main.temp"]
    }
}
