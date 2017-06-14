import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource{

    

    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    
    

    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var unit = "imperial"
    var lat = ""
    var lon = ""
    var refresh = true
    
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! UnitsCell
            //let cell = UnitsCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell1")
            cell.rulerImage?.image = UIImage(named: "icn-ruler")
            cell.unidadesLabel?.text = "Unidades"
            cell.unitsSelector?.selectedSegmentIndex = 0
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! MapViewCell
            //set the data here
            return cell
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
    
    @IBAction func notRefresh(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

