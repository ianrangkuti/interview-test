//
//  WeatherViewModel.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherViewModel {
  var showSuccess: PublishRelay<CurrentWeather> { get }
  var showError: PublishRelay<String> { get }
  var isLoading: PublishRelay<Bool> { get }
  
  func search()
}
