//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Yiding He on 7/18/19.
//  Copyright © 2019 Yiding He. All rights reserved.
//

import ChameleonFramework
import RealmSwift
import UIKit

class CategoryViewController: SwipeTableViewController {
    let realm = try! Realm()
    var categoryArray: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadItems()
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categoryArray?[indexPath.row] {
            guard let categoryColor = UIColor(hexString: category.color) else { fatalError() }
            
            cell.textLabel?.text = category.name
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { _ in
            
            let newItem = Category()
            newItem.name = textField.text!
            newItem.color = UIColor.randomFlat.hexValue()
            self.save(category: newItem)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("error: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    override func updateModel(at indexPeth: IndexPath) {
        if let categoryForDelete = categoryArray?[indexPeth.row] {
            do {
                try realm.write {
                    realm.delete(categoryForDelete)
                }
            } catch {
                print("Error delete \(error)")
            }
        }
    }
}
