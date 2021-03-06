//
//  UITableViewCell+WPSKit.swift
//
// Created by Kirby Turner.
// Copyright 2016 White Peak Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

public extension UITableViewCell {
  
  /**
   The cell identifier.
   
   This is the same as the class name.
   
   - return An `NSString` containing the cell identifier.
   */
  public static var cellIdentifier: String {
    return String(describing: self)
  }
  
  /**
   Get a reference to the nib associated with this class.
   
   - return A reference to the `UINib` associated with this class.
   */
  public static var nib: UINib? {
    let bundle = Bundle.init(for: self)
    guard let _ = bundle.path(forResource: nibName, ofType: "nib") else {
      return nil
    }
    return UINib.init(nibName: nibName, bundle: bundle)
  }
  
  /**
   The nib's name.
   
   This is the same as the class name.
   
   - return An `NSString` representing the nib's name.
   */
  public static var nibName: String {
    return cellIdentifier
  }
  
  /**
   Register the class for use as a cell with the provided table view.
   
   - parameter tableView: The table view that will use this cell class.
   */
  public static func registerClassWithTableView(_ tableView: UITableView) {
    tableView.register(self, forCellReuseIdentifier: cellIdentifier)
  }
  
  /**
   Register the nib for this class for use as a cell with the provided table view.
   
   - parameter tableView: The table view that will use this cell class.
   */
  public static func registerNibWithTableView(_ tableView: UITableView) {
    tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
  }
}

public extension UITableViewCell {
  
  public func tableView() -> UITableView? {
    var someView = self.superview
    while someView != nil {
      if let tableView = someView as? UITableView {
        return tableView
      }
      someView = someView?.superview
    }
    return nil
  }
  
}
