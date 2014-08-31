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

        if picker.respondsToSelector(Selector("predicateForEnablingPerson")) {
            picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }

        presentViewController(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) {
        let multiValue: ABMultiValueRef = ABRecordCopyValue(person, property).takeRetainedValue()
        let index = ABMultiValueGetIndexForIdentifier(multiValue, identifier)
        let email = ABMultiValueCopyValueAtIndex(multiValue, index).takeRetainedValue() as String

        println("email = \(email)")
    }

    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!, property: ABPropertyID, identifier: ABMultiValueIdentifier) -> Bool {
        
        peoplePickerNavigationController(peoplePicker, didSelectPerson: person, property: property, identifier: identifier)
        
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
        
        return false;
    }

    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    }
}
