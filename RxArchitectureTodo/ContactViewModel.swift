//
//  ContactViewModel.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import Action

typealias ContactSection = AnimatableSectionModel<String,ContactItem>

struct ContactViewModel {
  
  let sceneCoordinator: SceneCoordinatorType
  let contactService: ContactServiceType
  
  init(contactService: ContactServiceType, coordinator: SceneCoordinatorType) {
    self.contactService = contactService
    self.sceneCoordinator = coordinator
  }
  
  var sectionItems: Observable<[ContactSection]> {
    return self.contactService.getContacts().map({ item in
      return [ContactSection(model: "", items: item)]
    })
  }
  
  func onUpdateTitle(task: ContactItem) -> CocoaAction {
    return CocoaAction { newTitle in
      return self.contactService.update(contact: task, to: task).map { _ in }
    }
  }
  
  func onGetContactDetail(contact: ContactItem) -> CocoaAction {
    return CocoaAction {
      return self.contactService.getContact(id: contact.id)
        .flatMap({ task -> Observable<Void> in
          let detailViewModel = ContactDetailViewModel(task: task, coordinator: self.sceneCoordinator)
          return self.sceneCoordinator.transition(to: Scene.contactDetail(detailViewModel), type: .modal)
        })
    }
  }
}
