//
//  HomepageViewModel.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 14.05.2024.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var hrepo = ContactsRepository()
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    init(){
        databaseCopy()
        contactsList = hrepo.contactsList
    }
    
    func search(searchKey:String){
        hrepo.search(searchKey: searchKey)
    }
    
    func delete(kisi_id:Int){
        hrepo.delete(contact_id: kisi_id)
        contactsUp()
    }
    
    func contactsUp(){
        hrepo.contactsUp()
    }
    
    func databaseCopy(){
            let bundlePath = Bundle.main.path(forResource: "contacts", ofType: ".sqlite") //the main path of the database bundle
            let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("contacts.sqlite") //Copy path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: databaseURL.path){
                print("Database already exist!")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundlePath!, toPath: databaseURL.path) //Copy done!
                }catch{}
            }
        }
}
