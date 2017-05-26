//
//  WriteViewController.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 25..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit
import RealmSwift

class WriteViewController: UIViewController {
    
    fileprivate static let placeHolderMessage: String = "Content"
    fileprivate let dateFormat: String = "yyyy-MM-dd"
    
    fileprivate var realm: Realm!
    fileprivate var memo: Memo?
    
    fileprivate let creationDateLabel: UILabel = {
        let creationDateLabel: UILabel = UILabel(frame: .zero)
        creationDateLabel.textColor = UIColor.gray
        return creationDateLabel
    }()
    
    fileprivate let titleTextField: UITextField = {
        let titleTextField: UITextField = UITextField(frame: .zero)
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .none
        titleTextField.sizeToFit()
        titleTextField.font = UIFont.systemFont(ofSize: 18.0)
        return titleTextField
    }()
    
    fileprivate let contentTextView: UITextView = {
        let contentTextView: UITextView = UITextView(frame: .zero)
        contentTextView.textColor = .lightGray
        contentTextView.text = WriteViewController.placeHolderMessage
        contentTextView.font = UIFont.systemFont(ofSize: 16.0)
        return contentTextView
    }()
    
    fileprivate let okButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                    target: nil,
                                                                    action: nil)
    fileprivate let cancelButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                        target: nil,
                                                                        action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view background color
        self.view.backgroundColor = .white
        
        // textview delegate
        self.contentTextView.delegate = self
        
        // add subView
        self.view.addSubview(self.creationDateLabel)
        self.view.addSubview(self.titleTextField)
        self.view.addSubview(self.contentTextView)
        
        // auto layout
        self.creationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        self.titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.creationDateLabel.snp.bottom)
            make.left.equalTo(self.creationDateLabel.snp.left)
            make.width.equalTo(self.creationDateLabel.snp.width)
            make.height.equalTo(35)
        }
        self.contentTextView.snp.makeConstraints { make in
            make.top.equalTo(self.titleTextField.snp.bottom)
            make.left.equalTo(self.creationDateLabel.snp.left)
            make.width.equalTo(self.creationDateLabel.snp.width)
            make.bottom.equalTo(self.view.snp.bottom)
        }
        
        memoDataLabelUpdate()
    }
    
    init(title: String, realmObject: Realm, memo: Memo? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.realm = realmObject
        self.memo = memo
        
        self.navigationItem.rightBarButtonItem = self.okButtonItem
        self.navigationItem.leftBarButtonItem = self.cancelButtonItem
        
        self.okButtonItem.target = self
        self.okButtonItem.action = #selector(okButtonItemTouchUpInside)
        self.cancelButtonItem.target = self
        self.cancelButtonItem.action = #selector(cancelButtonItemTouchUpInside)
        
        self.creationDateLabel.text = dateTypeToString()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func okButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        if let memo = self.memo {
            do {
                try self.realm.write {
                    memo.memoTitle = self.titleTextField.text
                    memo.memoContents = self.contentTextView.text
                }
            } catch let error {
                print("realm update error : \(error)")
            }
        } else {
            let newMemo: Memo = Memo()
            newMemo.creationDate = dateStringToDateType(dateString: self.creationDateLabel.text!)
            newMemo.memoTitle = self.titleTextField.text
            newMemo.memoContents = self.contentTextView.text
            
            do {
                try self.realm.write {
                    self.realm.add(newMemo)
                }
            } catch let error {
                print("real add error : \(error)")
            }
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: General method
    
    func memoDataLabelUpdate() {
        guard let memo = self.memo else { return }
        self.creationDateLabel.text = dateTypeToString(date: memo.creationDate)
        self.titleTextField.text = memo.memoTitle
        self.contentTextView.textColor = .black
        self.contentTextView.text = memo.memoContents
    }
    
    func dateTypeToString(date: Date = Date()) -> String {
        let nowFormatter: DateFormatter = DateFormatter()
        nowFormatter.dateFormat = self.dateFormat
        let nowDate: String = nowFormatter.string(from: date)
        return nowDate
    }
    
    func dateStringToDateType(dateString: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = self.dateFormat
        return formatter.date(from: dateString)!
    }
}

extension WriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = WriteViewController.placeHolderMessage
            textView.textColor = .lightGray
        }
    }
}
