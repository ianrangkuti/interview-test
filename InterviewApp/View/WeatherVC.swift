//
//  WeatherVC.swift
//  InterviewApp
//
//  Created by Ardiansyah Rangkuti on 17/01/2024.
//

import Foundation
import UIKit
import RxSwift
import SDWebImage

class WeatherVC: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var weatherIcon: UIImageView!
  
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var temperatureValueLabel: UILabel!
  
  @IBOutlet weak var windSpeedLabel: UILabel!
  @IBOutlet weak var windSpeedValueLabel: UILabel!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var descriptionValueLabel: UILabel!
  
  @IBOutlet weak var errorValueLabel: UILabel!
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  
  private let disposeBag: DisposeBag
  
  private let viewModel: WeatherViewModel
  
  init() {
    self.disposeBag = .init()
    self.viewModel = WeatherViewModelImpl(disposeBag: self.disposeBag)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadingView.isHidden = true
    self.errorValueLabel.isHidden = true
    self.weatherIcon.isHidden = true
    self.temperatureLabel.isHidden = true
    self.temperatureValueLabel.isHidden = true
    self.windSpeedLabel.isHidden = true
    self.windSpeedValueLabel.isHidden = true
    self.descriptionLabel.isHidden = true
    self.descriptionValueLabel.isHidden = true
    self.observeViewModel()
  }
  
  func observeViewModel() {
    self.searchBar.rx.text.orEmpty
      .bind(to: self.viewModel.searchText)
      .disposed(by: disposeBag)
    
    self.viewModel.isLoading
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { isLoading in
        if isLoading {
          self.loadingView.isHidden = false
          self.loadingView.startAnimating()
          
          self.errorValueLabel.isHidden = true
          self.weatherIcon.isHidden = true
          self.temperatureLabel.isHidden = true
          self.temperatureValueLabel.isHidden = true
          self.windSpeedLabel.isHidden = true
          self.windSpeedValueLabel.isHidden = true
          self.descriptionLabel.isHidden = true
          self.descriptionValueLabel.isHidden = true
        } else {
          self.loadingView.isHidden = true
          self.loadingView.stopAnimating()
        }
      })
      .disposed(by: disposeBag)
    
    self.viewModel.showSuccess
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { currentWeather in
        self.errorValueLabel.isHidden = true
        self.weatherIcon.isHidden = false
        
        self.temperatureLabel.isHidden = false
        self.temperatureValueLabel.isHidden = false
        
        self.windSpeedLabel.isHidden = false
        self.windSpeedValueLabel.isHidden = false
        
        self.descriptionLabel.isHidden = false
        self.descriptionValueLabel.isHidden = false
        if let urlString = currentWeather.weatherIcons?.first, let url = URL(string: urlString) {
          self.weatherIcon.sd_setImage(with: url)
        }
        
        self.temperatureValueLabel.text = currentWeather.temperature?.description
        self.windSpeedValueLabel.text = currentWeather.windSpeed?.description
        self.descriptionValueLabel.text = currentWeather.weatherDescriptions?.first
        
      })
      .disposed(by: disposeBag)
    
    self.viewModel.showError
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { error in
        self.errorValueLabel.isHidden = false
        self.weatherIcon.isHidden = true
        
        self.temperatureLabel.isHidden = true
        self.temperatureValueLabel.isHidden = true
        
        self.windSpeedLabel.isHidden = true
        self.windSpeedValueLabel.isHidden = true
        
        self.descriptionLabel.isHidden = true
        self.descriptionValueLabel.isHidden = true
        
        self.errorValueLabel.text = error
      })
      .disposed(by: disposeBag)
  }
}

extension WeatherVC: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.viewModel.search()
  }
}
