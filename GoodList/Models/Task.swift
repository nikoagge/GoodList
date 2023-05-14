//
//  Task.swift
//  GoodList
//
//  Created by Nikos Aggelidis on 14/5/23.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
