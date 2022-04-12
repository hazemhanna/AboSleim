//
//  Errors.swift
//  AboSleim
//
//  Created by MAC on 12/04/2022.
//  Copyright © 2022 Dtag. All rights reserved.
//

import Foundation
// MARK: - Errors
struct Errors: Codable {
    
    var email: [String]?
    
    enum CodingKeys: String, CodingKey {
        case email
    }
}

struct BaseModel:  Codable {
    let value: Bool?
    let msg: String?
    enum CodingKeys: String, CodingKey {
        case value,msg
    }
}
