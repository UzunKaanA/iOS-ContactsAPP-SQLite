//
//  ContactsRepository.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 14.05.2024.
//

import Foundation
import RxSwift

class ContactsRepository {
    
    let db:FMDatabase?
    
    init() {
        let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("contacts.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    var contactsList = BehaviorSubject<[Kisiler]>(value: [Kisiler]())
    
    func contactSave(contact_name:String, contact_number:String) {
        db?.open()
        
        do{
            try db!.executeUpdate(
                "INSERT INTO kisiler (kisi_ad,kisi_tel) VALUES (?,?)",
                values: [contact_name,contact_number]
            ) //first "?" name, second-> number
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(contact_id:Int, contact_name:String, contact_number:String){
        db?.open()
        
        do{
            try db!.executeUpdate(
                "UPDATE kisiler SET kisi_ad = ? , kisi_tel = ? WHERE kisi_id = ?",
                values: [contact_name,contact_number,contact_id]
            )
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func search(searchKey:String){
        
        db?.open()
        
        var list = [Kisiler]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(searchKey)%'", values: nil)
            
            while rs.next(){
                let kisi_id = Int(rs.string(forColumn: "kisi_id"))
                let kisi_ad = rs.string(forColumn: "kisi_ad")
                let kisi_tel = rs.string(forColumn: "kisi_tel")
                
                let kisi = Kisiler(kisi_id: kisi_id!, kisi_ad: kisi_ad!, kisi_tel: kisi_tel!)
                
                list.append(kisi)
            }
            
            contactsList.onNext(list)//Triggering
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(contact_id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate(
                "DELETE FROM kisiler WHERE kisi_id = ?",
                values: [contact_id]
            )
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func contactsUp(){
        
        
        db?.open()
        
        var list = [Kisiler]()
        do{
            let rs = try db!.executeQuery("SELECT * FROM kisiler", values: nil)
            
            while rs.next(){
                let kisi_id = Int(rs.string(forColumn: "kisi_id"))
                let kisi_ad = rs.string(forColumn: "kisi_ad")
                let kisi_tel = rs.string(forColumn: "kisi_tel")
                
                let kisi = Kisiler(kisi_id: kisi_id!, kisi_ad: kisi_ad!, kisi_tel: kisi_tel!)
                
                list.append(kisi)
            }
            
            contactsList.onNext(list)//Triggering
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
}
