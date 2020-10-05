//
//  SelectCurrencyViewModel.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

struct SelectCurrencyViewModel {
    
    var currency: String?
    var initials: String?
    
    init(currency: String, initials: String) {
        self.currency = currency
        self.initials = initials
    }
}
