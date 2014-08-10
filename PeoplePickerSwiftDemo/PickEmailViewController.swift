//
//  PickEmailViewController.swift
//  PeoplePickerSwiftDemo
//
//  Created by Robert Ryan on 8/9/14.
//  Copyright (c) 2014 Robert Ryan. All rights reserved.
//

import UIKit
import AddressBookUI

class PickEmailViewController: UIViewController, ABPeoplePickerNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pick", style: .Plain, target: self, action: Selector("didTouchUpInsidePickButton:"))
    }

    func didTouchUpInsidePickButton(item: UIBarButtonItem) {
        let picker = ABPeoplePickerNavigationController()
        picker.peoplePickerDelegate = self
        picker.displayedProperties = [NSNumber(int: kABPersonEmailProperty)]
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        let multiValue: ABMultiValueRef = ABRecordCopyValue(person, property).takeUnretainedValue()
        let index = ABMultiValueGetIndexForIdentifier(multiValue, identifier)
        let email = ABMultiValueCopyValueAtIndex(multiValue, index).takeUnretainedValue() as String

        println("email = \(email)")
    }

}
