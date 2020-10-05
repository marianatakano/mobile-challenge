//
//  CurrencyConverterInfrastructure.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

class CurrencyConverterInfrastructure: CurrencyConverterInfrastructureProtocol {
    
    var apiGetAdapter: APIGetAdapterProtocol = APIGetAdapter()
    
    func getListCurrency(completrionHandler: @escaping (ListCurrencyResponse?, InfraError) -> Void) {
        
        apiGetAdapter.getSimpleAPI(url: "http://api.currencylayer.com/live?access_key=31836fc6e231ecdd01acc8f228cb6da6") { (resultData, error) -> Void in
            if error == .noError {
                let decoder = JSONDecoder()
                
                do {
                    let gitResponse = try decoder.decode(ListCurrencyResponse.self, from: resultData!)
                    completrionHandler(gitResponse, .noError)
                } catch {
                    completrionHandler(nil, .convertionJsonError)
                }
                
            } else {
                completrionHandler(nil, .genericError)
            }
        }
    }
    
    func getListCurrencyQuote(completionHandler: @escaping (ListCurrencyQuoteResponse?, InfraError) -> Void) {
        
        apiGetAdapter.getSimpleAPI(url: "http://api.currencylayer.com/live?access_key=31836fc6e231ecdd01acc8f228cb6da6") { (resultData, error) -> Void in
            if error == .noError {
                let decoder = JSONDecoder()
                
                do {
                    let gitResponse = try decoder.decode(ListCurrencyQuoteResponse.self, from: resultData!)
                    completionHandler(gitResponse, .noError)
                } catch {
                    completionHandler(nil, .convertionJsonError)
                }
                
            } else {
                completionHandler(nil, .genericError)
            }
        }
    }
}
