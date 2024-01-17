//
//  WeatherRepositoryImpl.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation
import SwiftyJSON
import RxSwift

class WeatherRepositoryImpl: WeatherRepository {
  
  let weatherService: WeatherService
  
  init(weatherService: WeatherService = WeatherServiceImpl()) {
    self.weatherService = weatherService
  }
  
  func getCurrentWeather(location: String) -> Observable<CurrentWeather> {
    return Observable<CurrentWeather>.create { observer -> Disposable in
      self.weatherService.getCurrentWeather(location: location) { isSuccess, successResponse in
        if isSuccess, let successResponse = successResponse, let currentWeather = successResponse.current {
          observer.onNext(currentWeather)
        } else if !isSuccess  {
          observer.onError(RxError.unknown)
        }
        observer.onCompleted()
      }
      return Disposables.create {}
    }
  }
}
