//
// StringTests.swift
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

import XCTest
@testable import WPSKit

class StringTests: XCTestCase {
  
  let pathComponents = "_unittest"
  var pathsToDelete: [String] = []
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    let fm = FileManager.default
    for path in pathsToDelete {
      if fm.fileExists(atPath: path) {
        try! fm.removeItem(atPath: path)
      }
    }
    super.tearDown()
  }

  // MARK: - Document Directory
  
  func testDocumentDirectory() {
    let dir = String.documentDirectory()
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
  }
  
  func testDocumentDirectoryWithPathComponents() {
    let dir = try! String.documentDirectory(pathComponents)
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
    pathsToDelete.append(dir!)
  }

  // MARK: Cache Directory
  
  func testCacheDirectory() {
    let dir = String.cacheDirectory()
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
  }
  
  func testCacheDirectoryWithPathComponents() {
    let dir = try! String.cacheDirectory(pathComponents)
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
    pathsToDelete.append(dir!)
  }

  // MARK: Temporary Directory
  
  func testTemporaryDirectory() {
    let dir = String.temporaryDirectory()
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
  }
  
  func testTemporaryDirectoryWithPathComponents() {
    let dir = try! String.temporaryDirectory(pathComponents)
    XCTAssertNotNil(dir)
    XCTAssertTrue(FileManager.default.fileExists(atPath: dir!))
    pathsToDelete.append(dir!)
  }

}
