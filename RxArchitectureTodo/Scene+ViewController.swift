/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

extension Scene {
  func viewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    switch self {
    case .contacts(let viewModel):
      let nc = storyboard.instantiateViewController(withIdentifier: "contactNav") as! UINavigationController
      var vc = nc.viewControllers.first as! ContactListViewController
      vc.bindViewModel(to: viewModel)
      return nc
    case .contactDetail(let viewModel):
        var vc = storyboard.instantiateViewController(withIdentifier: "ContactDetailViewController") as! ContactDetailViewController
        vc.bindViewModel(to: viewModel)
       
        // Before: We'll you need to change the storyboard as well, caue right now `ContactDetailViewController` is not a rootViewController of UINavigationController
        
//        let nc = storyboard.instantiateViewController(withIdentifier: "ContactDetailNav") as! UINavigationController
//        var vc = nc.viewControllers.first as! ContactDetailViewController
//        vc.bindViewModel(to: viewModel)
//        return nc
      return vc
    }
  }
}
