//
//  APIGetAdapter.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation

class APIGetAdapter: APIGetAdapterProtocol {
    
    func getSimpleAPI(url: String, completrionHandler: @escaping (Data?, AdapterError) -> Void) {
        let urlString = url
        if let url = URL(string: urlString)
        {
            URLSession.shared.dataTask(with: url) { data, res, err in
                if let data = data {
                    completrionHandler(data, .noError)
                } else {
                    completrionHandler(nil, .genericError)
                }
            } .resume()
        }
    }
}
