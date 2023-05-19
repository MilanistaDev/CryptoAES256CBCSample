//
//  TopContentType.swift
//  CryptoAES256CBCSample
//
//  Created by Takuya Aso on 2023/05/17.
//

import Foundation

enum TopContentType: CaseIterable {
    case encryption
    case decryption

    var title: String {
        switch self {
        case .encryption:
            return "Encryption Sample"

        case .decryption:
            return "Decryption Sample"
        }
    }
}
