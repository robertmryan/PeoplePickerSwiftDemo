//
//  PickContactViewController.swift
//  PeoplePickerSwiftDemo
//
//  Created by Robert Ryan on 8/9/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

import UIKit
import AddressBookUI

class PickContactViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pick", style: .Plain, target: self, action: Selector("didTouchUpInsidePickButton:"))
    }

    func didTouchUpInsidePickButton(item: UIBarButtonItem) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        presentViewController(picker, animated: true, completion: nil)
    }

    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeUnretainedValue()
        if (ABMultiValueGetCount(emails) > 0) {
            let index = 0 as CFIndex
            let email = ABMultiValueCopyValueAtIndex(emails, index).takeUnretainedValue() as String

            println("first email for selected contact = \(email)")
        } else {
            println("No email address")
        }
    }
}