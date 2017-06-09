import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0

    var weatherForecastList = [JSONWeatherForecastMappable]()

    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var unit = "imperial"
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
            
            /*ApiClientWeather.shared.getCurrentWeather(unit, self.lat, self.lon){ (weather,error) in
                if let weather = weather {
                    self.weatherIconLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
                    self.temperatureLabel.text = String(weather.temperature)
                    self.cityLabel.text = weather.name
                    if (self.unit == "metric") {
                        self.unitLabel.text = "ºC"
                    } else {
                        self.unitLabel.text = "ºF"
                    }
                }
                if let error = error{
                    print(error)
                }
            }*/
            
            
            ApiClientWeather.shared.getForecastWeather(unit, self.lat, self.lon){ (weatherList, error) in
                if let weatherList = weatherList {
                    self.weatherForecastList = weatherList
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UICollectionViewDelegate y UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dayCell", for: indexPath) as! CustomCollectionViewCell
        
        let weather = self.weatherForecastList[indexPath.row] // usar este weather!!!
        cell.dayWeekLabel.text = "LUNES!"
        cell.dayWeatherIconDayLabel.text = ""
        cell.dayTemperatureLabel.text = String(25)
        if (self.unit == "metric") {
            cell.dayUnitLabel.text = "ºC"
        } else {
            cell.dayUnitLabel.text = "ºF"
        }
        
        return cell
    }
}





