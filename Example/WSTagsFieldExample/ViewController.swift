//
//  ViewController.swift
//  WSTagsFieldExample
//
//  Created by Ricardo Pereira on 04/07/16.
//  Copyright © 2016 Whitesmith. All rights reserved.
//

import UIKit
import WSTagsField

class ViewController: UIViewController {
  
    let tagsField = WSTagsField()
    let anotherField = UITextField()
    let testButton = UIButton(type: .system)
    let readOnlyToggleButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        tagsField.frame = tagsView.bounds
        tagsView.addSubview(tagsField)

        tagsField.placeholder = "Enter a tag"
        tagsField.backgroundColor = .white
        tagsField.frame = CGRect(x: 0, y: 44, width: 200, height: 44)
        tagsField.delegate = self
        view.addSubview(tagsField)
        tagsField.returnKeyType = .next
        tagsField.delimiter = " "

        tagsField.placeholderAlwayVisible = true
        tagsField.maxHeight = 100.0

        textFieldEventss()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagsField.beginEditing()
    }

    override func viewWillLayoutSubviews() {
        tagsField.frame = tagsView.bounds
    }

    @IBAction func touchReadOnly(_ sender: UIButton) {
        tagsField.readOnly = !tagsField.readOnly
        sender.isSelected = tagsField.readOnly
    }

    @IBAction func touchTest(_ sender: UIButton) {
        tagsField.addTag("test1")
        tagsField.addTag("test2")
        tagsField.addTag("test3")
        tagsField.addTag("test4")
    }
}

extension ViewController {
    fileprivate func textFieldEventss() {
        tagsField.onDidAddTag = { _ in
            print("DidAddTag")
        }

        tagsField.onDidRemoveTag = { _ in
            print("DidRemoveTag")
        }

        tagsField.onDidChangeText = { _, text in
            print("onDidChangeText")
        }

        tagsField.onDidBeginEditing = { _ in
            print("DidBeginEditing")
        }

        tagsField.onDidEndEditing = { _ in
            print("DidEndEditing")
        }

        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }

        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }

        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
      
        anotherField.frame = CGRect(x: 0, y: 250, width: 120, height: 44)
        anotherField.backgroundColor = .white
        anotherField.placeholder = "another field"
        anotherField.delegate = self
        view.addSubview(anotherField)

        testButton.frame = CGRect(x: 0, y: 300, width: 100, height: 44)
        testButton.backgroundColor = .white
        testButton.setTitle("Test", for: UIControlState())
        view.addSubview(testButton)
        testButton.addTarget(self, action: #selector(didTouchTestButton), for: .touchUpInside)
        
        readOnlyToggleButton.frame = CGRect(x: 0, y: 350, width: 120, height: 44)
        readOnlyToggleButton.backgroundColor = .white
        readOnlyToggleButton.setTitle("Read Only", for: UIControlState())
        view.addSubview(readOnlyToggleButton)
        readOnlyToggleButton.addTarget(self, action: #selector(didTouchReadOnlyToggleButton), for: .touchUpInside)
    }

    func didTouchTestButton(_ sender: AnyObject) {
        tagsField.padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tagsField.spaceBetweenTags = 10.0
        tagsField.font = .systemFont(ofSize: 12.0)
        tagsField.tintColor = .green
        tagsField.textColor = .black
        tagsField.fieldTextColor = .blue
        tagsField.selectedColor = .black
        tagsField.selectedTextColor = .red
        tagsField.delimiter = ","
        tagsField.acceptTagOption = .space
        tagsField.returnKeyType = .go
        print(tagsField.tags)
    }
    
    func didTouchReadOnlyToggleButton(_ sender: AnyObject) {
        tagsField.readOnly = !tagsField.readOnly
        if tagsField.readOnly {
            readOnlyToggleButton.setTitle("Enable Editing", for: UIControlState())
        } else {
            readOnlyToggleButton.setTitle("Read Only", for: UIControlState())
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        if tagsField.isEditing == false {
            tagsField.beginEditing()
        }
        super.viewDidAppear(animated)
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tagsField {
            anotherField.becomeFirstResponder()
        }
        return true
    }

}
