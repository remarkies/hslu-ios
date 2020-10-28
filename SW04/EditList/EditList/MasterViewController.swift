//
//  MasterViewController.swift
//  EditList
//
//  Created by Luka Kramer on 05.10.20.
//

import UIKit

class MasterViewController: UITableViewController {
    
    let dataProvider = DataProvider.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return dataProvider.memberPersons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let person = dataProvider.memberPersons[indexPath.row]
        cell.textLabel?.text = "\(person.firstName) \(person.lastName)"
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? ViewController
        vc?.title = "DetailView"
        let indexPath = self.tableView.indexPathForSelectedRow!
        vc?.person = dataProvider.memberPersons[indexPath.row]
        
    }
    

}
