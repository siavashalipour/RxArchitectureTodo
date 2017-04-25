//
//  BidableType.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import UIKit

protocol BindableType {
  
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! {get set}
  
  func bindViewModel()
}

extension BindableType where Self: UIViewController {
  mutating func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
