//
//  ContactItem.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RealmSwift
import Unbox
import RxDataSources

typealias JSONObject = [String: Any]

class ContactItem: Object, Unboxable {
  
  dynamic var id: String = ""
  dynamic var firstName: String = ""
  dynamic var lastName: String = ""
  dynamic var active: Bool = true
  dynamic var rank: Int = 0
  dynamic var company: String = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  required convenience init(unboxer: Unboxer) throws {
    self.init()
    id = try unboxer.unbox(key: "id")
    firstName = try unboxer.unbox(key: "firstName")
    lastName = try unboxer.unbox(key: "lastName")
    active = try unboxer.unbox(key: "active")
    rank = try unboxer.unbox(key: "rank")
    company = try unboxer.unbox(key: "company")
    
  }
  static func unboxMany(stores: [JSONObject]) -> [ContactItem] {
    return (try? unbox(dictionaries: stores, allowInvalidElements: true) as [ContactItem]) ?? []
  }
}

extension ContactItem: IdentifiableType {
  var identity: String {
    return self.isInvalidated ? "" : id
  }
}
