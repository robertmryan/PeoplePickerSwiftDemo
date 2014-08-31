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

        if picker.respondsToSelector(Selector("predicateForEnablingPerson")) {
            picker.predicateForEnablingPerson = NSPredicate(format: "emailAddresses.@count > 0")
        }

        presentViewController(picker, animated: true, completion: nil)
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecordRef!) {
        let emails: ABMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty).takeRetainedValue()
        if (ABMultiValueGetCount(emails) > 0) {
            let index = 0 as CFIndex
            let email = ABMultiValueCopyValueAtIndex(emails, index).takeRetainedValue() as String
            
            println("first email for selected contact = \(email)")
        } else {
            println("No email address")
        }
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecordRef!) -> Bool {
        
        peoplePickerNavigationController(peoplePicker, didSelectPerson: person)
        
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
        
        return false;
    }
    
    func peoplePickerNavigationControllerDidCancel(peoplePicker: ABPeoplePickerNavigationController!) {
        peoplePicker.dismissViewControllerAnimated(true, completion: nil)
    }
}
