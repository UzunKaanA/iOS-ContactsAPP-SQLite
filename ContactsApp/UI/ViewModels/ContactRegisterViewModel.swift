//
//  ContactRegisterViewModel.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 14.05.2024.
//

import Foundation

class ContactRegisterViewModel {
    
    var crepo = ContactsRepository()
    
    func contactSave(contact_name:String, contact_number:String) {
        crepo.contactSave(contact_name: contact_name, contact_number: contact_number)
    }
}
