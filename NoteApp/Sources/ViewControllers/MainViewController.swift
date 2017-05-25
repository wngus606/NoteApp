//
//  MainViewController.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 25..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    fileprivate let memoTableView: MemoTableView = {
        let memoTableView: MemoTableView = MemoTableView(frame: .zero, style: .plain)
        memoTableView.backgroundColor = .clear
        memoTableView.alwaysBounceVertical = true
        memoTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "memoCell")
        return memoTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation title
        self.title = "Note pad"
        
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self

        let addBarButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                target: self,
                                                                action: #selector(addBarButtonTouchupInside))
        
        self.navigationItem.leftBarButtonItem = addBarButtonItem
        self.memoTableView.tableFooterView = UIView()
        self.view.addSubview(self.memoTableView)
        
        // auto layout
        self.memoTableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: actions
    
    func addBarButtonTouchupInside(_ sender: Any) {
        print("add memo")
    }
}


// MARK: TableView Data source

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoTableViewCell
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

// MARK: TableView Delegate

extension MainViewController: UITableViewDelegate {
    
}

