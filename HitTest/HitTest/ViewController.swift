//
//  ViewController.swift
//  HitTest
//
//  Created by Aaron Lee on 2021/12/17.
//

import CoreData
import UIKit

fileprivate let cellIdentifier = "Cell"

class ViewController: UIViewController {
  
  private var people: [NSManagedObject] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Name List"
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: cellIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
    
    do {
      people = try managedContext.fetch(fetchRequest)
    } catch let e {
      print(e)
    }
  }

  @IBAction func addName(_ sender: Any) {
    
    let alert = UIAlertController(title: "New Name",
                                  message: "Add a new name",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) { [weak self] _ in
      guard let self = self,
            let textField = alert.textFields?.first,
            let nameToSave = textField.text else { return }
      
      self.save(name: nameToSave)
      self.tableView.reloadData()
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel)
    
    alert.addTextField()
    alert.textFields?.first?.textContentType = .name
    alert.textFields?.first?.autocapitalizationType = .words
    alert.textFields?.first?.returnKeyType = .done
    alert.textFields?.first?.enablesReturnKeyAutomatically = true
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true)
    
  }
  
  private func save(name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    guard let entity = NSEntityDescription.entity(forEntityName: "Person",
                                                  in: managedContext) else {
      return
    }
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    person.setValue(name, forKey: "name")
    
    do {
      try managedContext.save()
      people.append(person)
    } catch let e {
      print(e)
    }
  }
  
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let person = people[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    
    cell.setSelected(false, animated: false)
    cell.textLabel?.text = person.value(forKey: "name") as? String
    
    return cell
  }
  
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.setSelected(false, animated: true)
  }
  
}
