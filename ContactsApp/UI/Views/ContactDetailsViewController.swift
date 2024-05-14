//
//  ContactDetailsViewController.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 5.05.2024.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    
    var viewModel = ContactsDetailsViewModel()

  @IBOutlet weak var tfContactName: UITextField!
  @IBOutlet weak var tfContactNumber: UITextField!

  var contact:Kisiler?

  override func viewDidLoad() {
    super.viewDidLoad()
    if let c = contact{
      tfContactName.text = c.kisi_ad
      tfContactNumber.text = c.kisi_tel
    }
  }

  @IBAction func buttonUpdate(_ sender: Any) {
      if let c = contact, let name = tfContactName.text,let number = tfContactNumber.text {
          viewModel.update(contact_id: c.kisi_id!, contact_name: name , contact_number: number)
      }
  }
}
