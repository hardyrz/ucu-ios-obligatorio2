import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    
    var weatherForecastList: [JSONWeatherMappable]? = nil
    
    var refreshForecast = true
    var refreshWeather = true
    
    
    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    var unit = "metric"
    var lat = ""
    var lon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor .clear
        //For use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        //For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate=self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.lat = String(location.coordinate.latitude)
            self.lon = String(location.coordinate.longitude)
            
            print(self.lat)
            print(self.lon)
            
            if (self.refreshWeather) {
                ApiClientWeather.shared.getCurrentWeather(unit, self.lat, self.lon){ (weather,error) in
                    if let weather = weather {
                        self.refreshWeather = false
                        self.weatherIconLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
                        self.temperatureLabel.text = String(weather.temperature)
                        self.cityLabel.text = weather.name
                        if (self.unit == "metric") {
                            self.temperatureLabel.text = self.temperatureLabel.text! + "ºC"
                        } else {
                            self.temperatureLabel.text = self.temperatureLabel.text! + "ºF"
                        }
                    }
                    if let error = error{
                        print(error)
                    }
                }
            }
            
            if (self.refreshForecast) {
                ApiClientWeather.shared.getForecastWeather(unit, self.lat, self.lon){ (weatherList, error) in
                    if let weatherList = weatherList {
                        self.refreshForecast = false
                        let day1 = JSONWeatherMappable()
                        day1?.iconId = weatherList.iconId1
                        day1?.iconString = weatherList.iconString1
                        day1?.temperature = weatherList.temperature1
                        
                        let day2 = JSONWeatherMappable()
                        day2?.iconId = weatherList.iconId2
                        day2?.iconString = weatherList.iconString2
                        day2?.temperature = weatherList.temperature2
                        
                        let day3 = JSONWeatherMappable()
                        day3?.iconId = weatherList.iconId3
                        day3?.iconString = weatherList.iconString3
                        day3?.temperature = weatherList.temperature3
                        
                        let day4 = JSONWeatherMappable()
                        day4?.iconId = weatherList.iconId4
                        day4?.iconString = weatherList.iconString4
                        day4?.temperature = weatherList.temperature4
                        
                        let day5 = JSONWeatherMappable()
                        day5?.iconId = weatherList.iconId5
                        day5?.iconString = weatherList.iconString5
                        day5?.temperature = weatherList.temperature5
                        
                        let day6 = JSONWeatherMappable()
                        day6?.iconId = weatherList.iconId6
                        day6?.iconString = weatherList.iconString6
                        day6?.temperature = weatherList.temperature6
                        
                        var weather = [JSONWeatherMappable]()
                        weather.append(day1!)
                        weather.append(day2!)
                        weather.append(day3!)
                        weather.append(day4!)
                        weather.append(day5!)
                        weather.append(day6!)
                        
                        
                        self.weatherForecastList = weather
                        self.collectionView.reloadData()
                    }
                    /*for weather in weatherList as [JSONWeatherForecastMappable]! {
                     self.weatherIconDayLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
                     self.temperatureDayLabel.text = String(weather.temperature)
                     if (self.unit == "metric") {
                     self.unitDayLabel.text = "ºC"
                     } else {
                     self.unitDayLabel.text = "ºF"
                     }
                     }*/
                    if let error = error{
                        print(error)
                    }
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UICollectionViewDelegate y UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CustomCollectionViewCell
        
        if let weatherForecastList = self.weatherForecastList {
            let weather = weatherForecastList[indexPath.row] // usar este weather!!!
            cell.dayWeekLabel.text = "LUNES!"
            cell.dayWeatherIconDayLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
            cell.dayTemperatureLabel.text = String(weather.temperature)
            if (self.unit == "metric") {
                cell.dayUnitLabel.text = "ºC"
            } else {
                cell.dayUnitLabel.text = "ºF"
            }
        }
        return cell
    }
}





