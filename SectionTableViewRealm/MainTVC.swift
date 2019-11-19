//
//  ViewController.swift
//  SectionTableViewRealm
//
//  Created by Josh R on 11/13/19.
//  Copyright © 2019 Josh R. All rights reserved.
//

import UIKit
import RealmSwift

//This TVC creates the unique section headers then use those section header dates as the filter criteria

class MainTVC: UITableViewController {
    
    fileprivate let cellID = "cellID"
    fileprivate let headerID = "headerID"
    
    let realm = MyRealm.getConfig()
    var transactions: Results<Transaction>?
    var transactionToken: NotificationToken?
    
    var sections = [Date]()
    
    lazy var addBtn: AddBtn = {
        let button = AddBtn()
        button.setTitle("Add Transaction", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let realm = realm else { return }
        transactions = realm.objects(Transaction.self)
        
        tableView.register(TransactionCell.self, forCellReuseIdentifier: cellID)
        tableView.register(TransactionHeaderView.self,
        forHeaderFooterViewReuseIdentifier: headerID)
        
        print(realm.configuration.fileURL ?? "Realm local url not found")
        
        addBtn.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        setupNavBar()
        tableView.tableFooterView = UIView()
        
        transactionToken = transactions?.observe { [ weak tableView, weak self] changes in
            guard let tableView = tableView else { return }
            switch changes {
            case .initial:
                self?.createSectionHeaders()
                tableView.reloadData()
            case .update:
                self?.createSectionHeaders()
                tableView.reloadData()
            case .error: break
            }
        }
    }
    
    @objc func addBtnTapped() {
        let toVC = AddTransactionVC()
        toVC.modalPresentationStyle = .fullScreen  //forces fullscreen in ios13
        toVC.modalTransitionStyle = .crossDissolve
        self.present(toVC, animated: true, completion: nil)
    }
    
    private func createSectionHeaders() {
        transactions?.forEach({ sections.append($0.date.dateAtStartOf(.day)) })
        sections = Array(Set(sections)).sorted(by: >)  //converting it to a Set then back to an array removes the duplicate values
    }
    
    fileprivate func printSectionHeaders() {
        sections.forEach({
            print($0.formatDateMonthDDYYYY())
        })
    }
    
    private func setupNavBar() {
        self.title = "Transactions"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupConstraints() {
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        addBtn.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
        addBtn.widthAnchor.constraint(equalToConstant: 225).isActive = true
        addBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addBtn.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.addSubview(addBtn)  //if the add button is added in ViewDidLoad or ViewWillAppear, the button will be under the custom header view
        setupConstraints()
    }
    
    deinit {
        transactionToken?.invalidate()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionDate = sections[section]
        let startOfPeriod = sectionDate.dateAtStartOf(.day)
        let endOfPeriod = sectionDate.dateAtEndOf(.day)
        return transactions?.filter("date BETWEEN {%d, %d}", startOfPeriod, endOfPeriod).count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TransactionCell else { return UITableViewCell() }
        
        let sectionDate = self.sections[indexPath.section]
        guard let transactions = transactions else { return UITableViewCell() }
        let startOfPeriod = sectionDate.dateAtStartOf(.day)
        let endOfPeriod = sectionDate.dateAtEndOf(.day)
        
        let transaction = transactions.filter("date BETWEEN {%d, %d}", startOfPeriod, endOfPeriod).sorted(by: { $0.date > $1.date })[indexPath.row]
  
        cell.transaction = transaction

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
        headerID) as! TransactionHeaderView
        
        var sectionTitles = [String]()
        sections.forEach({ sectionTitles.append($0.convertDateToString()) })
        
        headerView.titleLbl.text = sectionTitles[section]
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionDate = self.sections[indexPath.section]
        guard let transactions = transactions else { return }
        let startOfPeriod = sectionDate.dateAtStartOf(.day)
        let endOfPeriod = sectionDate.dateAtEndOf(.day)
        
        let transaction = transactions.filter("date BETWEEN {%d, %d}", startOfPeriod, endOfPeriod).sorted(by: { $0.date > $1.date })[indexPath.row]
        print(transaction.amount)
    }
}


