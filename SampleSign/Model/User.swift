//
//  User.swift
//  SampleSign
//
//  Created by mtanaka on 2022/07/13.
//

import Foundation

struct User: Codable {
    let uid: String
    let email: String
    let username: String
    let createdAt: Date
}
