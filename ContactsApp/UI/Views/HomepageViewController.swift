//
//  ViewController.swift
//  ContactsApp
//
//  Created by Kaan Uzun on 5.05.2024.
//

import UIKit
import RxSwift

class HomepageViewController: UIViewController {
    var viewModel = HomepageViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    var contactsList = [Kisiler]()
    
    
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self //-> SearchBar's delegate to self -> UISearchBarDelegate connection.
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        _ = viewModel.contactsList.subscribe(onNext: { liste in
            self.contactsList = liste
            self.contactsTableView.reloadData()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.contactsUp()
        //When the page shows up, data's will be loaded.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let contact = sender as? Kisiler { //Downcasting from Any
                let destinationVC = segue.destination as! ContactDetailsViewController    //Sending the contact X to Details Page.
                destinationVC.contact = contact
            }
        }
    }
    
}

extension HomepageViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchKey: searchText)
    }
    
}


//MARK: TableView
extension HomepageViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsList.count  //will run this much* * *
    }
    
    //Giving data to rows
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell") as! ContactsTableViewCell
        
        let contactPerson = contactsList[indexPath.row]
        cell.labelName.text = contactPerson.kisi_ad
        cell.labelNumber.text = contactPerson.kisi_tel
        
        return cell
    }
    
    //Selecting row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactPerson = contactsList[indexPath.row]
        //sending data to the "Contact Details Page" with an identifier
        performSegue(withIdentifier: "toDetails", sender: contactPerson)
        //removes the UIview of the "stuck" selected row view.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ){
            contexualAction,view,bool in
            
            let contactPerson = self.contactsList[indexPath.row]
            
            let alert = UIAlertController(title: "Deletion", message: "\(contactPerson.kisi_ad!) + Are you sure to delete?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            let eventAction = UIAlertAction(title: "Yes", style: .destructive){ _ in
                self.viewModel.delete(kisi_id: contactPerson.kisi_id!)
            }
            alert.addAction(eventAction)
            
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
}
