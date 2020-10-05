//
//  SelectCurrencyViewController.swift
//  Cambio
//
//  Created by Mariana Takano on 05/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController {
    
    var child = ActivityViewController()
    
    var selectCurrencyList: [SelectCurrencyViewModel] = []
        
    lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    // Presenter
    var selectCurrency: SelectCurrencyPresenterProtocol = SelectCurrencyPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: "cellId")
        self.initializer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initializer() {
        self.showLoadingView()
        selectCurrency.requestCurrencyData() { [weak self] (result, error) -> Void in
            if error == .noError {
                self!.selectCurrencyList = result
                
                self!.hideLoadingView()
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self!.hideLoadingView()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Falha na comunicação", message: "Tente novamente", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Sim", style: .default, handler: { action in
                        self!.initializer()
                    }))
                    
                    self!.present(alert, animated: true)
                }
            }
        }
    }
}

extension SelectCurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectCurrencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! CurrencyTableViewCell
        cell.currencyLabel.text = selectCurrencyList[indexPath.row].currency
        cell.initialsLabel.text = selectCurrencyList[indexPath.row].initials
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if CurrencySelectConversionSingleton.currencySelect == currencySelect.origin {
            CurrencySelectConversionSingleton.currency1 = selectCurrencyList[indexPath.row].initials
        } else if CurrencySelectConversionSingleton.currencySelect == currencySelect.destiny {
            CurrencySelectConversionSingleton.currency2 = selectCurrencyList[indexPath.row].initials
        }
        
        navigationController?.popViewController(animated: false)
    }
}

extension SelectCurrencyViewController: ViewCodeProtocol {
    
    func viewCodeSetup() {
        view.addSubview(tableView)
    }
    
    func viewCodeHierarchySetup() {
        
        tableView.snp.remakeConstraints { (mkr) in
            mkr.leading.trailing.topMargin.bottomMargin.equalToSuperview()
        }
    }
    
    func viewCodeConstraintSetup() {
        
        view.backgroundColor = .white
        
        tableView.separatorStyle = .singleLine
        tableView.allowsSelection = true
    }
    
    func viewCodeAdditionalSetup() {
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }
}

extension SelectCurrencyViewController {
    
    func showLoadingView() {
        DispatchQueue.main.async {
            self.child = ActivityViewController()
            self.addChild(self.child)
            self.child.view.frame = self.view.frame
            self.view.addSubview(self.child.view)
            self.child.didMove(toParent: self)
        }
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        }
    }
}
