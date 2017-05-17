//
//  ViewController.swift
//  myweather
//
//  Created by Winston Tabar on 2017/05/12.
//  Copyright © 2017年 Winston Tabar. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    // Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    
    // Location Manager
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    // var forecast: Forecast!
    var forecasts = [Forecast]()
    
    // System
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
        // forecast = Forecast()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        }
        
        // locationManager.requestWhenInUseAuthorization()
        // locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    // Run before download weather details
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationAuthStatus()
        }
    }

    // info plist: Privacy - Location When in Use, then put message you want dialog. 
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            locationManager.startMonitoringSignificantLocationChanges()
            
            currentLocation = locationManager.location
            // save current location to static vars 
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                // TODO: move here the ui below
                self.downloadForecastData{
                    // Setup UI
                    self.updateMainUI() // call self if within closure
                    self.tableView.reloadData()
                }
            }
            
            
        } /*else {
            // TODO: code when no internet connection and when no data for tablvw
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }*/
    }
    
    
    // TODO: big degree font, why ang next day is still same day? 
    func downloadForecastData(completed: @escaping DownloadComplete) {
        
        let forecastURL = URL(string: FORECAST_URL)!
        print(forecastURL)
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, Any> {
                if let list = dict["list"] as? [Dictionary<String, Any>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print("hey\(obj)")
                    }
                    self.forecasts.remove(at: 0)
                    // self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    // TableView functions
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    // Create a cell to recreate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(format: "%.0f°", currentWeather.currentTemp)
        locationLabel.text = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
    // Actions


}

