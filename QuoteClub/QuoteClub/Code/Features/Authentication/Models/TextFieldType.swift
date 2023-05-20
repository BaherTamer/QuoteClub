//
//  TextFieldType.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import Foundation

enum TextFieldType: String {
    case email
    case password
    case fullName = "Full Name"
    case username
}

extension TextFieldType {
    var icon: String {
        switch self {
        case .email:
            return "envelope"
        case .password:
            return "lock"
        case .fullName:
            return "person"
        case .username:
            return "at"
        }
    }
}
