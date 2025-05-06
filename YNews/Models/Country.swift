//
//  Country.swift
//  YNews
//
//  Created by Brusik on 5/5/25.
//

import Foundation

enum Country: String, CaseIterable, Codable {
    case us
    case gb
    case ca
    case au
    case de
    case fr
    case it
    case ua
    case jp
    case cn
    
    var displayName: String {
        switch self {
        case .us: return "United States"
        case .gb: return "United Kingdom"
        case .ca: return "Canada"
        case .au: return "Australia"
        case .de: return "Germany"
        case .fr: return "France"
        case .it: return "Italy"
        case .ua: return "Ukraine"
        case .jp: return "Japan"
        case .cn: return "China"
        }
    }
}

