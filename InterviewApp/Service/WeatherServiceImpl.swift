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
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching films: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
          print("Error with the response, unexpected status code: \(String(describing: response))")
          completion(false, nil)
          return
        }
        
        if let data = data, let json = try? JSON.init(data: data, options: .fragmentsAllowed) {
          if json["success"] == false {
            completion(false, nil)
          } else {
            let currentWeather = try? JSONDecoder().decode(Weather.self, from: data)
          }
        } else {
          completion(false, nil)
        }
      })
      task.resume()
    }
  }
}
