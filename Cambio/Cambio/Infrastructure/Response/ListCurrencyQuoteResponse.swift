//
//  ListCurrencyQuoteResponse.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

struct ListCurrencyQuoteResponse: Decodable {
    var quotes: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case quotes
    }
}
