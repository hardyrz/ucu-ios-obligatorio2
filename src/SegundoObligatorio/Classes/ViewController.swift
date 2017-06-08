import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    

    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    var unit = "imperial"
    var lat = ""
    var lon = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        ApiClientWeather.shared.getCurrentWeather(unit, self.lat, self.lon){ (weather,error) in
            if let weather = weather{
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
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.lat = String(location.coordinate.latitude)
            self.lon = String(location.coordinate.longitude)
            
            ApiClientWeather.shared.getCurrentWeather(unit, self.lat, self.lon){ (weather,error) in
                if let weather = weather{
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
            }
            
            print(self.lat)
            print(self.lon)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

