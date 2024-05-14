//
//  ContactsDetailsViewModel.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 14.05.2024.
//

import Foundation

class ContactsDetailsViewModel {
    var crepo = ContactsRepository()
    
    func update(contact_id:Int, contact_name:String, contact_number:String){
        crepo.update(contact_id: contact_id, contact_name: contact_name, contact_number: contact_number)
    }
}
