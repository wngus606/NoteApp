//
//  WriteViewController.swift
//  NoteApp
//
//  Created by seo on 2017. 5. 25..
//  Copyright © 2017년 seoju. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {
    
    fileprivate static let placeHolderMessage: String = "Content"
    
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
    
    fileprivate let okButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                    target: nil,
                                                                    action: nil)
    fileprivate let cancelButtonItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                        target: nil,
                                                                        action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentTextView.delegate = self
        
        self.view.addSubview(self.creationDateLabel)
        self.view.addSubview(self.titleTextField)
        self.view.addSubview(self.contentTextView)
        
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
    }
    
    init(title: String) {
        super.init(nibName: nil, bundle: nil)
        self.title = title
        
        self.okButtonItem.target = self
        self.okButtonItem.action = #selector(okButtonItemTouchUpInside)
        self.cancelButtonItem.target = self
        self.cancelButtonItem.action = #selector(cancelButtonItemTouchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
    
    func okButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonItemTouchUpInside(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
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