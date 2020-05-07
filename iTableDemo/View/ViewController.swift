//
//  ViewController.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cardCellID = "CardCell"
    var tableView: UITableView!
    var refreshControl = UIRefreshControl()

    private var webService: WebService!
    private var countryViewModel: CountryListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCountryData()
        addTableVieToView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    /// Function to refresh tableview data with webservice
    @objc fileprivate func refreshList() {
        self.countryViewModel.getCountryInfo()
    }

    fileprivate func getCountryData() {
        self.webService = WebService()
        self.countryViewModel = CountryListViewModel(webservice: webService)
        self.countryViewModel.delegate = self
    }

    /// Function to reload and update tableview
    fileprivate func updateTableViewHeight() {
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
    }

    /// Function to initialize and setup tableview
    fileprivate func addTableVieToView() {
        self.tableView = UITableView(frame: self.view.bounds, style: .plain)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView?.backgroundColor = .white
        tableView.register(CardCell.self, forCellReuseIdentifier: cardCellID)
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tableView.allowsSelection = false
        tableView.contentInset.top = 20
        tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let contentSize = self.tableView.contentSize
        let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                          y: self.tableView.frame.origin.y + contentSize.height,
                                          width: self.tableView.frame.size.width,
                                          height: self.tableView.frame.height - self.tableView.contentSize.height))
        self.tableView.tableFooterView = footer
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing--")
        refreshControl.addTarget(self, action: #selector(self.refreshList), for: .valueChanged)
        tableView.addSubview(refreshControl)
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryViewModel.getList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cardCellID, for: indexPath) as? CardCell else {
            return CardCell()
        }
        let countryInfo = self.countryViewModel.getList()[indexPath.row]
        let card = CardVM(cardTitle: countryInfo.header ?? "", cardImage: countryInfo.imgUrl ?? "", cardDescription: countryInfo.desc ?? "")
        cell.card = card
        return cell
    }
}

extension ViewController: CountryListViewModelProtocol {
    func refreshFailure() {
        //api failed
        refreshControl.endRefreshing()
    }
    func refreshModelList() {
        self.navigationItem.title = self.countryViewModel.getTitle()
        refreshControl.endRefreshing()
        tableView.reloadData()
        updateTableViewHeight()
    }
}
