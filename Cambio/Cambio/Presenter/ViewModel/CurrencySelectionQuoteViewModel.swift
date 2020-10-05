//
//  CurrencySelectionQuoteViewModel.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

struct CurrencySelectionQuoteViewModel {
    var calculatedValue: Double?
    
    init(calculatedValue: Double) {
        self.calculatedValue = calculatedValue
    }
}
