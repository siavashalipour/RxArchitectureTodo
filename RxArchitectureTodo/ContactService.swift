//
//  ContactService.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm
import RxCocoa
import Unbox

struct ContactService: ContactServiceType {
  enum Errors: Error {
    case requestFailed
    case badResponse
    case httpError(Int)
  }
  func getContacts() -> Observable<[ContactItem]> {
    return request(address: URL.init(string: "https://thecontactsapi.restlet.net/v1/contacts")!).map(ContactItem.unboxMany)
    
  }
  @discardableResult
  func update(contact: ContactItem, to: ContactItem) -> Observable<ContactItem>{
    return request(address: URL.init(string: "https://thecontactsapi.restlet.net/v1/contacts")!).map({ item in
      return try ContactItem.init(unboxer: item)
      
    })
  }
  func getContact(id: String) -> Observable<ContactItem> {
    return requestJSON(address: URL.init(string: "https://thecontactsapi.restlet.net/v1/contacts/\(id)")!).map({ item in
      return try ContactItem.init(unboxer: Unboxer.init(dictionary: item))
    })
  }
//  static func getContact(id: String) -> Observable<ContactItem> {
//    
//  }
//  
//  @discardableResult
//  static func create(contact: ContactItem) -> Observable<ContactItem> {
//    
//  }
//  
//  @discardableResult
//  static func delete(contact: ContactItem) -> Observable<Void> {
//    
//  }
//  
//  @discardableResult
//  static func update(contact: ContactItem, to: ContactItem) -> Observable<ContactItem> {
//    
//  }
  private func request<T: Any>(address: URL, parameters: [String: String] = [:]) -> Observable<T> {
    return Observable.create { observer in
      let url = address
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
  
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
      let session = URLSession.shared
      session.dataTask(with: request, completionHandler: { (data, response, error) in
        if let error = error {
          observer.onError(error)
        }
        if let response = response, (response as! HTTPURLResponse).statusCode >= 400 && (response as! HTTPURLResponse).statusCode < 600 {
          observer.onError(Errors.httpError((response as! HTTPURLResponse).statusCode))
        }
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? T, let result = json {
          observer.onNext(result)
        }
        observer.onCompleted()
      }).resume()
  
      return Disposables.create()
    }
  }
  private func requestJSON(address: URL, parameters: [String: String] = [:]) -> Observable<[String: Any]> {
    return Observable.create { observer in
      let url = address
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
      let session = URLSession.shared
      session.dataTask(with: request, completionHandler: { (data, response, error) in
        if let error = error {
          observer.onError(error)
        }
        if let response = response, (response as! HTTPURLResponse).statusCode >= 400 && (response as! HTTPURLResponse).statusCode < 600 {
          observer.onError(Errors.httpError((response as! HTTPURLResponse).statusCode))
        }
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let result = json {
          observer.onNext(result)
        }
        observer.onCompleted()
      }).resume()
      
      return Disposables.create()
    }
  }
}


