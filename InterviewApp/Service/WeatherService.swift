//
//  WeatherService.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

protocol WeatherService {
  func getCurrentWeather(location: String, completion: @escaping ((_ result: Weather?) -> Void))
}
