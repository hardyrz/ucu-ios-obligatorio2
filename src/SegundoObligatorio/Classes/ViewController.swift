import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource  {
    
    
    let locationManager = CLLocationManager()
    var latitude: Double = 0
    var longitude: Double = 0
    
    var weatherForecastList: [JSONWeatherMappable]? = nil
    
    var refreshForecast = true
    var refreshWeather = true
    
    var dayList = ["Lun", "Mar", "Mie", "Jue", "Vie", "Sab", "Dom"]
    
    var unit = "metric"
    var lat = ""
    var lon = ""
    
    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func unitChanged(_ sender: Any) {
        if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
            if (unit == "metric") {
                UserDefaults.standard.setValue("imperial", forKey: "unit")
                UserDefaults.standard.setValue("true", forKey: "refreshForecast")
                UserDefaults.standard.setValue("true", forKey: "refreshWeather")
            } else {
                UserDefaults.standard.setValue("metric", forKey: "unit")
                UserDefaults.standard.setValue("true", forKey: "refreshForecast")
                UserDefaults.standard.setValue("true", forKey: "refreshWeather")
            }
        } else {
            UserDefaults.standard.setValue("metric", forKey: "unit")
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let collection = self.collectionView {
            self.collectionView.backgroundColor = UIColor .clear
        }
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
            if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
                if (unit == "metric") {
                    cell.unitsSelector?.selectedSegmentIndex = 0
                } else {
                    cell.unitsSelector?.selectedSegmentIndex = 1
                }
            }
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
            
            print(self.lat)
            print(self.lon)
            if let refreshWeather = UserDefaults.standard.object(forKey: "refreshWeather") as?  String {
                if (refreshWeather == "true") {
                    if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
                        ApiClientWeather.shared.getCurrentWeather(unit, self.lat, self.lon){ (weather,error) in
                            if let weather = weather {
                                if let label = self.weatherIconLabel {
                                    self.refreshWeather = false
                                    self.weatherIconLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
                                    self.temperatureLabel.text = String(weather.temperature)
                                    self.cityLabel.text = weather.name
                                    
                                    if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
                                        if (unit == "metric") {
                                            self.temperatureLabel.text = self.temperatureLabel.text! + "ºC"
                                        } else {
                                            self.temperatureLabel.text = self.temperatureLabel.text! + "ºF"
                                        }
                                    }
                                }
                                if let error = error{
                                    print(error)
                                }
                            }
                        }
                    }
                }
            } else {
                UserDefaults.standard.setValue("true", forKey: "refreshWeather")
            }
            
            if let refreshForecast = UserDefaults.standard.object(forKey: "refreshForecast") as?  String {
                if (refreshForecast == "true") {
                    if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
                        ApiClientWeather.shared.getForecastWeather(unit, self.lat, self.lon){ (weatherList, error) in
                            if let weatherList = weatherList {
                                if let label = self.weatherIconLabel {
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
                            }
                            
                            if let error = error{
                                print(error)
                            }
                        }
                    }
                } else {
                    UserDefaults.standard.setValue("true", forKey: "refreshForecast")
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
            let weather = weatherForecastList[indexPath.row]
            
            let today = Date()
            let day = Calendar.current.component(.weekday, from: today)
            let index = (day + indexPath.row) % 7
            
            cell.dayWeekLabel.text = self.dayList[index]
            cell.dayWeatherIconDayLabel.text = WeatherIcon(condition: weather.iconId, iconString: weather.iconString).iconText
            cell.dayTemperatureLabel.text = String(weather.temperature)
            if let unit = UserDefaults.standard.object(forKey: "unit") as?  String {
                if (unit == "metric") {
                    cell.dayUnitLabel.text = "ºC"
                } else {
                    cell.dayUnitLabel.text = "ºF"
                }
            }
        }
        return cell
    }
}





