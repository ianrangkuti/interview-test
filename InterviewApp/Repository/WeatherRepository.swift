//
//  WeatherRepository.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation
import RxSwift

protocol WeatherRepository {
  func getCurrentWeather(location: String) -> Observable<CurrentWeather>
}
