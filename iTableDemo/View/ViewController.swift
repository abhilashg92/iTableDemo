//
//  ViewController.swift
//  iTableDemo
//
//  Created by Abhilash Ghogale on 24/04/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let CardCellId = "CardCell"
    var tableView:UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updatUI()
        addTableVieToView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    /// Function to refresh tableview data with webservice
    @objc fileprivate func updatUI() {
    }
    
    /// Function to reload and update tableview
    fileprivate func updateTableViewHeight() {
        tableView.reloadData()
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
        
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCellId)
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView.contentInset.top = 20
        tableView.frame = CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight)
        let contentSize = self.tableView.contentSize
        let footer = UIView(frame: CGRect(x: self.tableView.frame.origin.x,
                                          y: self.tableView.frame.origin.y + contentSize.height,
                                          width: self.tableView.frame.size.width,
                                          height: self.tableView.frame.height - self.tableView.contentSize.height))
        
        self.tableView.tableFooterView = footer
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing--")
        refreshControl.addTarget(self, action: #selector(self.updatUI), for: .valueChanged)
        tableView.addSubview(refreshControl) 
        
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
    }
    
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCellId, for: indexPath) as! CardCell
        let product = CardVM(cardTitle: "Name", cardImage:  "", cardDescription:  "Description")
        cell.card = product
        
        return cell
    }
    
}
