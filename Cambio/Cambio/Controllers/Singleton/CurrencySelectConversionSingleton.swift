//
//  CurrencySelectConversionSingleton.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

struct CurrencySelectConversionSingleton {
    static var currency1: String?
    static var currency2: String?
    static var currencySelect: currencySelect?
}

enum currencySelect {
    case origin
    case destiny
}
