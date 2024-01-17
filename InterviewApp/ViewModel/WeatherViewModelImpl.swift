//
//  WeatherViewModelImpl.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation


import RxSwift
import RxCocoa

final class WeatherViewModelImpl: WeatherViewModel {
  var searchText: BehaviorRelay<String>
  var showSuccess: PublishRelay<CurrentWeather>
  var showError: PublishRelay<String>
  var isLoading: PublishRelay<Bool>
  
  let weatherRepository: WeatherRepository
  let disposeBag: DisposeBag
  
  init(disposeBag: DisposeBag, weatherRepository: WeatherRepository = WeatherRepositoryImpl()) {
    self.searchText = BehaviorRelay<String>(value: "")
    self.showSuccess = PublishRelay<CurrentWeather>()
    self.showError = PublishRelay<String>()
    self.isLoading = PublishRelay<Bool>()
    self.weatherRepository = weatherRepository
    self.disposeBag = disposeBag
  }
  
  func search() {
    self.isLoading.accept(true)
    self.weatherRepository.getCurrentWeather(location: self.searchText.value)
      .subscribe(onNext: { currentWeather in
        self.showSuccess.accept(currentWeather)
        self.isLoading.accept(false)
      }, onError: { _ in
        self.showError.accept("Something error, please try again")
        self.isLoading.accept(false)
      })
      .disposed(by: disposeBag)
  }
}
