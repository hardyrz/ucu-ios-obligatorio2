import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class ApiClientWeather{
    static let shared = ApiClientWeather()
    
    
    func getCurrentWeather(_ unit: String, _ lat: String, _ lon: String, _ onCompletion: @escaping (_ weather: JSONWeatherMappable?, _ error: Error?) -> Void){
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=50d32b989418aa24a61f174aa91d3a24&units=\(unit)"
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding(), headers:
            [:]).validate().responseJSON {(response: DataResponse<Any>) -> () in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let weather = Mapper<JSONWeatherMappable>().map(JSONObject: json.rawValue)
                    onCompletion(weather, nil)
                case .failure (let error):
                    onCompletion(nil,error)
                }
        }
    }
    
    
    func getForecastWeather(_ unit: String, _ lat: String, _ lon: String, _ onCompletion: @escaping (_ weatherList: [JSONWeatherForecastMappable]?, _ error: Error?) -> Void){
        
        let days = 6
        
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&cnt=\(days)&appid=50d32b989418aa24a61f174aa91d3a24&units=\(unit)"
        
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding(), headers:
            [:]).validate().responseJSON {(response: DataResponse<Any>) -> () in
                switch response.result{
                case .success(let value):
                    let json = JSON(value)
                    let weather = Mapper<JSONWeatherForecastMappable>().mapArray(JSONObject: json.rawValue)
                    onCompletion(weather, nil)
                case .failure (let error):
                    onCompletion(nil,error)
                }
        }
    }
}
