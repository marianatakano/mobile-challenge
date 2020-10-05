//
//  CurrencyConversionViewController.swift
//  Cambio
//
//  Created by Mariana Takano on 04/10/2020.
//  Copyright © 2020 iOS Developer. All rights reserved.
//

import UIKit
import SnapKit

class CurrencyConversionViewController: UIViewController {
    
    var child = ActivityViewController()
    
    lazy var scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    lazy var containerView: UIView = {
        return UIView()
    }()
    
    lazy var titleLabel: UILabel = {
        return UILabel()
    }()
    
    lazy var sourceButton: UIButton = {
       return UIButton()
    }()
    
    lazy var destinyButton: UIButton = {
        return UIButton()
    }()
    
    lazy var sourceTextField: UITextField = {
        return UITextField()
    }()
    
    lazy var destinyTextField: UITextField = {
        return UITextField()
    }()
    
    lazy var valueTextField: UITextField = {
        return UITextField()
    }()
    
    lazy var resultTextField: UITextField = {
        return UITextField()
    }()
    
    lazy var conversionButton: UIButton = {
        return UIButton()
    }()
    
    // Presenter
    var selectCurrency: SelectCurrencyPresenterProtocol = SelectCurrencyPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewCodeSetup()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        valueTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CurrencySelectConversionSingleton.currency1 == nil {
            sourceTextField.text = "UDS - Dólar americano"
        } else {
            sourceTextField.text = CurrencySelectConversionSingleton.currency1
        }
        
        if CurrencySelectConversionSingleton.currency2 == nil {
            sourceTextField.text = "BRL - Reais"
        } else {
            sourceTextField.text = CurrencySelectConversionSingleton.currency2
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            let curve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
            let curveAnimationOptions = UIView.AnimationOptions(rawValue: curve ?? 0 << 16)
            let height: CGFloat = keyboardSize.height // + 60 + self.bottomLayoutGuide.length
            UIView.animate(withDuration: duration ?? 0, delay: 0, options: curveAnimationOptions, animations: {
                self.scrollView.snp.remakeConstraints { (mkr) in
                    mkr.leading.trailing.topMargin.equalToSuperview()
                    mkr.bottomMargin.equalTo(self.conversionButton.snp.top).offset(-height)
                }
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func myTextFieldDidChange() {
        if let amountString = sourceTextField.text?.currencyImputFormat() {
            sourceTextField.text = amountString
        }
    }
    
    @objc func KeyboardWillHide(notification: NSNotification) {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        let curve = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
        let curveAnimationOptions = UIView.AnimationOptions(rawValue: curve ?? 0 << 16)
        UIView.animate(withDuration: duration ?? 0, delay: 0, options: curveAnimationOptions, animations: {
            self.scrollView.snp.remakeConstraints { (mkr) in
                mkr.leading.trailing.topMargin.equalToSuperview()
                mkr.bottomMargin.equalTo(self.conversionButton.snp.top).offset(-16)
            }
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func sourceCurrency(_ sender: UIButton) {
        navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
        CurrencySelectConversionSingleton.currencySelect = .origin
    }
    
    @objc func destinyCurrency(_ sender: UIButton) {
        navigationController?.pushViewController(SelectCurrencyViewController(), animated: true)
        CurrencySelectConversionSingleton.currencySelect = .destiny
    }
    
    @objc func convertCurrency(_ sender: UIButton) {
        self.showLoadingView()
        if  CurrencySelectConversionSingleton.currency2 == nil ||
            CurrencySelectConversionSingleton.currency1 == nil ||
        self.valueTextField.text == ""
        {
            self.hideLoadingView()
            DispatchQueue.main.sync {
                let alert = UIAlertController(title: "Erro", message: "Algum campo não foi preenchido", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            return
        }
        var valueText = valueTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        valueText = valueText.replacingOccurrences(of: ".", with: "")
        valueText = valueText.replacingOccurrences(of: ",", with: ".")
                
        selectCurrency.loadCurrencyData(origin: CurrencySelectConversionSingleton.currency1,
                                        destiny: CurrencySelectConversionSingleton.currency2,
                                        value: Double(valueText))
        { [weak self] (result, error) -> Void in
            self!.hideLoadingView()
            if error == .noError {
                DispatchQueue.main.async {
                    self!.resultTextField.text = String(format: "%.2f", result!).currencyImputFormat()
                }
            } else {
                self!.hideLoadingView()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Falha na comunicação", message: "Tente novamente", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Sim", style: .default, handler:
                        { action in
                            self!.convertCurrency(sender)
                    }))
                    self!.present(alert, animated: true)
                }
            }
        }
    }
}
    


// MARK: - VIEW CODE PROTOCOL

extension CurrencyConversionViewController: ViewCodeProtocol {
    
    func viewCodeHierarchySetup() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(sourceButton)
        containerView.addSubview(sourceTextField)
        containerView.addSubview(destinyButton)
        containerView.addSubview(destinyTextField)
        containerView.addSubview(valueTextField)
        containerView.addSubview(resultTextField)
        view.addSubview(conversionButton)
    }
    
    func viewCodeConstraintSetup() {
        
        scrollView.snp.remakeConstraints { (mkr) in
            mkr.leading.trailing.topMargin.equalToSuperview()
            mkr.bottomMargin.equalTo(conversionButton.snp.top).offset(-16)
        }
        
        containerView.snp.remakeConstraints { (mkr) in
            mkr.width.top.bottom.equalToSuperview()
            mkr.height.equalToSuperview().priority(256)
        }
        
        titleLabel.snp.makeConstraints { (mkr) in
            mkr.topMargin.equalToSuperview()
            mkr.left.right.equalToSuperview().inset(16)
            mkr.height.equalTo(70)
        }

        sourceButton.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(titleLabel.snp.bottom).offset(40)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
        }

        sourceTextField.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(sourceButton.snp.bottom).offset(16)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
        }

        destinyButton.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(sourceTextField.snp.bottom).offset(40)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
        }

        destinyTextField.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(destinyButton.snp.bottom).offset(16)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
        }

        valueTextField.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(destinyTextField.snp.bottom).offset(40)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
        }

        resultTextField.snp.makeConstraints { (mkr) in
            mkr.top.equalTo(valueTextField.snp.bottom).offset(16)
            mkr.left.right.equalToSuperview().inset(50)
            mkr.height.equalTo(40)
            mkr.bottom.equalToSuperview()
        }
        
        conversionButton.snp.makeConstraints { (mkr) in
            mkr.centerX.equalToSuperview()
            mkr.height.equalTo(50)
            mkr.left.right.equalToSuperview().inset(50)
            if #available(iOS 11.0, *) {
                mkr.bottomMargin.equalToSuperview().inset(view.safeAreaInsets.bottom + CGFloat(50))
            } else {
                mkr.bottomMargin.equalToSuperview().inset(50)
            }
        }
    }
    
    func viewCodeThemeSetup() {
        view.backgroundColor = .white
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.clipsToBounds = true
        
        containerView.clipsToBounds = true
        
        titleLabel.text = "Conversor de moedas"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .darkGray
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .center
        titleLabel.layoutIfNeeded()
        titleLabel.sizeToFit()
        titleLabel.accessibilityTraits = .header
        
        sourceButton.titleLabel?.font = .systemFont(ofSize: 16)
        sourceButton.layer.cornerRadius = 4
        sourceButton.backgroundColor = .lightGray
        sourceButton.setTitleColor(.purple, for: .normal)
        sourceButton.setTitle("Escolha a moeda de origem", for: .normal)
        sourceButton.contentHorizontalAlignment = .center
        sourceButton.accessibilityLabel = "Escolha a moeda de origem"
        sourceButton.addTarget(self, action: #selector(sourceCurrency), for: .touchUpInside)
        
        sourceTextField.font = .systemFont(ofSize: 20)
        sourceTextField.textAlignment = .center
        sourceTextField.textColor = .darkGray
        sourceTextField.layer.cornerRadius = 4
        sourceTextField.layer.borderColor = UIColor.lightGray.cgColor
        sourceTextField.layer.borderWidth = 2
        sourceTextField.isEnabled = false
        sourceTextField.placeholder = "UDS - Dólar americano"
        
        destinyButton.titleLabel?.font = .systemFont(ofSize: 16)
        destinyButton.layer.cornerRadius = 4
        destinyButton.backgroundColor = .lightGray
        destinyButton.setTitleColor(.purple, for: .normal)
        destinyButton.setTitle("Escolha a moeda de destino", for: .normal)
        destinyButton.contentHorizontalAlignment = .center
        destinyButton.accessibilityLabel = "Escolha a moeda de destino"
        destinyButton.addTarget(self, action: #selector(destinyCurrency), for: .touchUpInside)
        
        destinyTextField.font = .systemFont(ofSize: 20)
        destinyTextField.textAlignment = .center
        destinyTextField.textColor = .darkGray
        destinyTextField.layer.cornerRadius = 4
        destinyTextField.layer.borderColor = UIColor.lightGray.cgColor
        destinyTextField.layer.borderWidth = 2
        destinyTextField.isEnabled = false
        destinyTextField.placeholder = "BRL - Reais"
        
        valueTextField.font = .systemFont(ofSize: 20)
        valueTextField.textAlignment = .center
        valueTextField.textColor = .darkGray
        valueTextField.layer.cornerRadius = 4
        valueTextField.layer.borderColor = UIColor.lightGray.cgColor
        valueTextField.layer.borderWidth = 2
        valueTextField.isUserInteractionEnabled = true
        valueTextField.placeholder = "$ 1,00"
        valueTextField.keyboardAppearance = .light
        valueTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        valueTextField.autocorrectionType = .no
        
        resultTextField.font = .systemFont(ofSize: 20)
        resultTextField.textAlignment = .center
        resultTextField.textColor = .darkGray
        resultTextField.layer.cornerRadius = 4
        resultTextField.layer.borderColor = UIColor.lightGray.cgColor
        resultTextField.layer.borderWidth = 2
        resultTextField.isEnabled = false
        resultTextField.placeholder = "R$ 5,66"
        
        conversionButton.titleLabel?.font = .systemFont(ofSize: 20)
        conversionButton.layer.cornerRadius = 4
        conversionButton.layer.borderColor = UIColor.purple.cgColor
        conversionButton.layer.borderWidth = 2
        conversionButton.backgroundColor = .lightGray
        conversionButton.setTitleColor(.black, for: .normal)
        conversionButton.setTitle("converter", for: .normal)
        conversionButton.contentHorizontalAlignment = .center
        conversionButton.accessibilityLabel = "converter"
        conversionButton.addTarget(self, action: #selector(convertCurrency), for: .touchUpInside)
    }
    
    func viewCodeAdditionalSetup() {
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
    }
}

extension CurrencyConversionViewController {
    
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
