//
//  Memo.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 25..
//  Copyright © 2017년 seoju. All rights reserved.
//

import Foundation
import RealmSwift

class Memo: Object {
    
    dynamic var creationDate: Date = Date()
    dynamic var memoTitle: String?
    dynamic var memoContents: String?
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
