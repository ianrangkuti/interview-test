//
//  Weather.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation

struct Weather: Codable {
  let current: CurrentWeather?
}

struct CurrentWeather: Codable {
  let temperature: Int?
  let weatherIcons: [String]?
  let weatherDescriptions: [String]?
  let windSpeed: Int?
  let humidity: Int?
  
  enum CodingKeys: String, CodingKey {
    case temperature = "temperature"
    case weatherIcons = "weather_icons"
    case weatherDescriptions = "weather_descriptions"
    case windSpeed = "wind_speed"
    case humidity = "humidity"
  }
}
