//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import Foundation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager = WeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }
}

extension WeatherViewController: UITextFieldDelegate {

    //this will work when user presses enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true) //this is for dismising the keyboard
        return true
    }

    // user clicked elesewhere :- good for validation
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter the text "
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = textField.text{
            weatherManager.fetchData(cityName: city)
        }
        searchTextField.text = ""

    }

}

extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperatureString)
        print(weather.cityName)
    }
}
