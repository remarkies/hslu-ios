//
//  MasterViewController.swift
//  Persistency
//
//  Created by Luka Kramer on 19.10.20.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResultsController: NSFetchedResultsController<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonPressed(_:))
        )
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeFetchedResultsController()
    }
    
    func initializeFetchedResultsController() {
        let request: NSFetchRequest<Person> = NSFetchRequest(entityName: "Person")
        let nameSort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [nameSort]
        
        let moc: NSManagedObjectContext = self.context
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultsController.delegate = self
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            self.tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError("Unrecognized Change!")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            self.tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            self.tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            self.tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            self.tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            fatalError("Unrecognized Change!")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let frc = self.fetchedResultsController {
            return frc.sections!.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections found in fetchedResultsController")
        }
        
        return sections[section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let person = self.fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = person.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let selectedObject = fetchedResultsController.object(at: indexPath)
            self.context.delete(selectedObject)
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowDetail" {
            let destination = segue.destination as! ViewController
            destination.title = "User details"
            let indexPath:IndexPath = self.tableView.indexPathForSelectedRow!
            let selectedPerson: Person = self.fetchedResultsController.object(at: indexPath)
            destination.person = selectedPerson
            destination.managedContext = self.context
        }
    }
    
    @objc func addButtonPressed(_ sender: UIBarButtonItem) {
        let destination: EditViewController = self.storyboard!.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        destination.person = (NSEntityDescription.insertNewObject(forEntityName: "Person", into: self.context) as! Person)
        destination.managedContext = self.context
        self.present(destination, animated: true, completion: nil)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
}
