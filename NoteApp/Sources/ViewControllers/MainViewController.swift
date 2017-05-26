//
//  MainViewController.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 25..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    fileprivate var realm: Realm!
    fileprivate var memos: Results<Memo>!
    fileprivate var token: NotificationToken!
    
    fileprivate let memoTableView: MemoTableView = {
        let memoTableView: MemoTableView = MemoTableView(frame: .zero, style: .plain)
        memoTableView.backgroundColor = .white
        memoTableView.alwaysBounceVertical = true
        memoTableView.register(MemoTableViewCell.self, forCellReuseIdentifier: "memoCell")
        return memoTableView
    }()
    
    fileprivate let addButtonItem: UIBarButtonItem = {
        let addButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                             target: nil,
                                                             action: nil)
        return addButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(Realm.Configuration.defaultConfiguration.fileURL)")
        
        // Realm
        do {
            self.realm = try Realm()
        } catch let error {
            print("realm error : \(error)")
        }
        // realm objects
        self.memos = self.realm.objects(Memo.self).sorted(byKeyPath: "creationDate", ascending: false)
        // realm token
        self.token = self.memos.addNotificationBlock({ (result) in
            print("\(result)")
            self.memoTableView.reloadData()
        })
        
        // navigation title
        self.title = "Note pad"
        
        self.memoTableView.delegate = self
        self.memoTableView.dataSource = self

        self.addButtonItem.target = self
        self.addButtonItem.action = #selector(addButtonTouchupInside)
        self.navigationItem.leftBarButtonItem = self.addButtonItem
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
    
    func addButtonTouchupInside(_ sender: UIBarButtonItem) {
        let writeVC: WriteViewController = WriteViewController(title: "New Note", realmObject: self.realm)
        let navigationController: UINavigationController = UINavigationController(rootViewController: writeVC)
        self.present(navigationController, animated: true, completion: nil)
    }
}


// MARK: TableView Data source

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell") as! MemoTableViewCell
        let row: Int = indexPath.row
        
        cell.textLabel?.text = self.memos[row].memoTitle
        
        return cell
    }
}

// MARK: TableView Delegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? MemoTableViewCell else { return }
        let row: Int = indexPath.row
        let writeVC: WriteViewController = WriteViewController(title: "Modify Note", realmObject: self.realm, memo: self.memos[row])
        let navigationController: UINavigationController = UINavigationController(rootViewController: writeVC)
        self.present(navigationController, animated: true) {
        }
    }
}

