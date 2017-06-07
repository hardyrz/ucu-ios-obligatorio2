//
//  ViewController.swift
//  SegundoObligatorio
//
//  Created by Diego Pais on 5/18/16.
//  Copyright © 2016 Universidad Catolica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Main board
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherIconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    let unit = "imperial"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ApiClientWeather.shared.getCurrentWeather(unit){ (weather,error) in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

