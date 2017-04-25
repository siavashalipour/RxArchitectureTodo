//
//  ContactServiceType.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol ContactServiceType {
  
  func getContacts() -> Observable<[ContactItem]>
  func getContact(id: String) -> Observable<ContactItem>
//
//  @discardableResult
//  static func create(contact: ContactItem) -> Observable<ContactItem>
//  
//  @discardableResult
//  static func delete(contact: ContactItem) -> Observable<Void>
//  
  @discardableResult
  func update(contact: ContactItem, to: ContactItem) -> Observable<ContactItem>
}

enum ContactServiceError: Error {
  case creationFailed
  case updateFailed(ContactItem)
  case deletionFailed(ContactItem)
}
