//
//  ContactDetailViewController.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import UIKit


final class ContactDetailViewController: UIViewController, BindableType {
  
  var viewModel: ContactDetailViewModel!
  
  @IBOutlet weak var titleLabel: UILabel!
  
  @IBOutlet var cancelBtn: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  func bindViewModel() {
    titleLabel.text = viewModel.itemTitle
    cancelBtn.rx.action = viewModel.onCancel
  }
}
