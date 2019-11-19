//
//  SecondVC.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/14/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class AddTransactionVC: UIViewController {
    
    let realm = MyRealm.getConfig()
    
    let addTransactionView = AddTransactionView()
    
    lazy var addBtn: AddBtn = {
        let button = AddBtn()
        button.backgroundColor = .blue
        button.setTitle("Add", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        addViewsToVC()
        
        addTransactionView.amountTxt.addTarget(self, action: #selector(amountTxtChanged), for: .editingChanged)
        addBtn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        
        addTransactionView.amountTxt.becomeFirstResponder()
        setTextFieldDelegates()
    }
    
    @objc func amountTxtChanged() {
        addTransactionView.amountTxt.text = addTransactionView.amountTxt.text?.currencyInputFormatting()
    }
    
    @objc func addBtnTapped() {
        //Save to Realm
        do {
            try realm?.write {
                let newTransaction = Transaction()
                if let payeeTxt = addTransactionView.payeeTxt.text {
                    newTransaction.payee = payeeTxt
                }
                newTransaction.amount = addTransactionView.amountTxt.text?.cleanCurrencyFormatting() ?? 0.0
                newTransaction.date = addTransactionView.tranDatePicker.date
                
                realm?.add(newTransaction)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    private func addViewsToVC() {
        self.view.addSubview(addTransactionView)
        self.view.addSubview(addBtn)
        setupConstraints()
    }
    
    private func setTextFieldDelegates() {
        addTransactionView.amountTxt.delegate = self
        addTransactionView.payeeTxt.delegate = self
    }
    
    private func setupConstraints() {
        addTransactionView.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        addTransactionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 125).isActive = true
        addTransactionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        addTransactionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16).isActive = true
        addTransactionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addBtn.topAnchor.constraint(equalTo: addTransactionView.bottomAnchor, constant: 20).isActive = true
        addBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }


}

extension AddTransactionVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
