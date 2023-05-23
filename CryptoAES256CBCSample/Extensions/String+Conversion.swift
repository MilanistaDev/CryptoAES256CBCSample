//
//  String+Conversion.swift
//  CryptoAES256CBCSample
//
//  Created by Takuya Aso on 2023/05/23.
//

import Foundation

extension String {
  func utf8ToHexString() -> String {
      return self.utf8.map { NSString(format: "%2X", $0) as String }.reduce("", {$0 + $1})
  }
}
