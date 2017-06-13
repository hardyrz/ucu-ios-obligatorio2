import Foundation
import ObjectMapper

class JSONWeatherForecastMappable: Mappable {
    var iconId1:Int = 0
    var iconString1:String = ""
    var temperature1:Double = 0.0
    
    var iconId2:Int = 0
    var iconString2:String = ""
    var temperature2:Double = 0.0
    
    var iconId3:Int = 0
    var iconString3:String = ""
    var temperature3:Double = 0.0
    
    var iconId4:Int = 0
    var iconString4:String = ""
    var temperature4:Double = 0.0
    
    var iconId5:Int = 0
    var iconString5:String = ""
    var temperature5:Double = 0.0
    
    var iconId6:Int = 0
    var iconString6:String = ""
    var temperature6:Double = 0.0
    
    required init? (map: Map){
    }
    
    func mapping(map: Map) {
        iconId1      <- map["list.0.weather.0.id"]
        iconString1  <- map["list.0.weather.0.icon"]
        temperature1 <- map["list.0.temp.day"]
        
        iconId2      <- map["list.1.weather.0.id"]
        iconString2  <- map["list.1.weather.0.icon"]
        temperature2 <- map["list.1.temp.day"]
        
        iconId3      <- map["list.2.weather.0.id"]
        iconString3  <- map["list.2.weather.0.icon"]
        temperature3 <- map["list.2.temp.day"]
        
        iconId4      <- map["list.3.weather.0.id"]
        iconString4  <- map["list.3.weather.0.icon"]
        temperature4 <- map["list.3.temp.day"]
        
        iconId5      <- map["list.4.weather.0.id"]
        iconString5  <- map["list.4.weather.0.icon"]
        temperature5 <- map["list.4.temp.day"]
        
        iconId6      <- map["list.5.weather.0.id"]
        iconString6  <- map["list.5.weather.0.icon"]
        temperature6 <- map["list.5.temp.day"]
    }
}

