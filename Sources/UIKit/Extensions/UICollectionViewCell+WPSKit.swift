//
// UICollectionViewCell+WPSKit.swift
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

public extension UICollectionViewCell {

//  /**
//   The cell identifier.
//   
//   This is the same as the class name.
//   
//   - return An `NSString` containing the cell identifier.
//   */
//  public static var cellIdentifier: String {
//    return String(self)
//  }
//  
//  /**
//   Get a reference to the nib associated with this class.
//   
//   - return A reference to the `UINib` associated with this class.
//   */
//  public static var nib: UINib? {
//    let bundle = NSBundle.init(forClass: self)
//    guard let _ = bundle.pathForResource(nibName, ofType: "nib") else {
//      return nil
//    }
//    return UINib.init(nibName: nibName, bundle: bundle)
//  }
//  
//  /**
//   The nib's name.
//   
//   This is the same as the class name.
//   
//   - return An `NSString` representing the nib's name.
//   */
//  public static var nibName: String {
//    return cellIdentifier
//  }
  
  /**
   Register the class for use as a cell with the provided collection view.
   
   - parameter collectionView: The collection view that will use this cell class.
   */
  public static func registerClassWithCollectionView(_ collectionView: UICollectionView) {
    collectionView.register(self, forCellWithReuseIdentifier: cellIdentifier)
  }
  
  /**
   Register the nib for this class for use as a cell with the provided collection view.
   
   - parameter collectionView: The collection view that will use this cell class.
   */
  public static func registerNibWithCollectionView(_ collectionView: UICollectionView) {
    collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
  }
  
}
