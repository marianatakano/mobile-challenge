//
//  ActivityViewController.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewController: UIViewController {
    
    var load = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        load.translatesAutoresizingMaskIntoConstraints = false
        load.startAnimating()
        view.addSubview(load)
        
        load.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        load.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
