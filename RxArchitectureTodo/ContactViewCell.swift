//
//  ContactViewCell.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import UIKit
import Action
import RxSwift

final class ContactViewCell: UITableViewCell {
  @IBOutlet var title: UILabel!
  @IBOutlet var button: UIButton!
 
  var disposeBag = DisposeBag()
  
  func configure(with item: ContactItem, action: CocoaAction) {
    button.rx.action = action
    
    item.rx.observe(String.self, "firstName")
      .subscribe(onNext: { [weak self] title in
        self?.title.text = title
      })
      .addDisposableTo(disposeBag)
    
//    item.rx.observe(Date.self, "checked")
//      .subscribe(onNext: { [weak self] date in
//        let image = UIImage(named: date == nil ? "ItemNotChecked" : "ItemChecked")
//        self?.button.setImage(image, for: .normal)
//      })
//      .addDisposableTo(disposeBag)
  }
  
  override func prepareForReuse() {
    button.rx.action = nil
    disposeBag = DisposeBag()
    super.prepareForReuse()
  }
}
