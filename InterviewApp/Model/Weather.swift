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
}
