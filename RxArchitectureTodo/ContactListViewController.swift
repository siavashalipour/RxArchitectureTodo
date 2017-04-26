//
//  ViewController.swift
//  RxArchitectureTodo
//
//  Created by Siavash on 25/4/17.
//  Copyright © 2017 Fika. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import Action
import NSObject_Rx

class ContactListViewController: UIViewController, BindableType {

  @IBOutlet var tableView: UITableView!

  
  var viewModel: ContactViewModel!
  let dataSource = RxTableViewSectionedAnimatedDataSource<ContactSection>()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60
    
    configureDataSource()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func bindViewModel() {
    viewModel.sectionItems
      .bind(to: tableView.rx.items(dataSource: dataSource))
      .addDisposableTo(self.rx_disposeBag)
  }
  fileprivate func configureDataSource() {
    dataSource.titleForHeaderInSection = { dataSource, index in
      dataSource.sectionModels[index].model
    }
    
    dataSource.configureCell = {
      [weak self] dataSource, tableView, indexPath, item in
      let cell = tableView.dequeueReusableCell(withIdentifier: "ContactViewCell", for: indexPath) as! ContactViewCell
      if let strongSelf = self {
        // before:
//        cell.configure(with: item, action: strongSelf.viewModel.onGetContactDetail(contact: item))
        cell.configure(with: item, action: strongSelf.viewModel.onGetContactDetail(contact: item, navController: strongSelf.navigationController!))
      }
      return cell
    }
    
    dataSource.canEditRowAtIndexPath = { _ in true }
  }
}

