//
//  WeatherServiceImpl.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation
import SwiftyJSON
import RxSwift

class WeatherServiceImpl: WeatherService {
  
  func getCurrentWeather(location: String, completion: @escaping ((_ isSuccess: Bool, _ result: Weather?) -> Void)) {
    let baseUrl = "http://api.weatherstack.com/current?access_key=e1cab0e1c5aaa8af0576c9e5ebabcc21&query="
    if let urlString = "\(baseUrl)\(location)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
       let url = URL(string: urlString) {
      // Handle api call in here
    }
  }
}
