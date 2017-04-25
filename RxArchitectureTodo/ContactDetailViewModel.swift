//
//  ContactDetailViewModel.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RxSwift
import Action

struct ContactDetailViewModel {
  
  let itemTitle: String

  let disposeBag = DisposeBag()
  let onCancel: CocoaAction!
  
  init(task: ContactItem, coordinator: SceneCoordinatorType, cancelAction: CocoaAction? = nil) {
    itemTitle = task.firstName
    onCancel = CocoaAction {
      if let cancelAction = cancelAction {
        cancelAction.execute()
      }
      return coordinator.pop()
    }
  }
}
