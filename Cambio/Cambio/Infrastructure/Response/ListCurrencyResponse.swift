//
//  ListCurrencyResponse.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

struct ListCurrencyResponse: Decodable {
    var currencies: [String : String]?
    
    enum CodingKeys: String, CodingKey {
        case currencies
    }
}
