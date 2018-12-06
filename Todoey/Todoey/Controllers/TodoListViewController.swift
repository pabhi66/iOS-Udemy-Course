//
//  ViewController.swift
//  Todoey
//
//  Created by Abhi on 12/5/18.
//  Copyright © 2018 Abhishek Prajapati. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    // user defaults
//    let defaults = UserDefaults.standard
    
    // Encode data with NSCoder
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupNevigation()
        
        // add few mock todos
//        let todo = Item()
//        todo.title = "Buy Milk"
//        itemArray.append(todo)
//
//        let todo1 = Item()
//        todo1.title = "Buy Bread"
//        itemArray.append(todo1)
//
//        let todo2 = Item()
//        todo2.title = "Buy Eggs"
//        itemArray.append(todo2)

        loadItems()
        
        // load data from user defaults storage
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        loadItems()
        
    }
    
    func setupNevigation() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
    
    // MARK: - Tableview data source methods
    
    // returns number of items to display in table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    // returns each cell in the table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
    
        return cell
    }
    
    // MARK: - Tableview delegate methods
    
    // when user selects the cell in the table view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        // add check mark
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        self.saveItems()
        
        // deselect the cell. When we click there is a grey selected color which tells the cell is selected but it does not go away after selecting. This will make it go away.
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen when the user clicks add item in alert box
            let newTodo = Item()
            newTodo.title = textField.text ?? "New Item"
            self.itemArray.append(newTodo)
            // stpre the new array to the user's local database with key "TodoListArray"
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            // store data in encoder
            self.saveItems()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Todo"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Model Manipulation Method
    func saveItems() {
        // store data in encoder
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding itemArray, \(error)")
        }
        // reload data
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: self.dataFilePath!) {
            let decoer = PropertyListDecoder()
            do {
                itemArray = try decoer.decode([Item].self, from: data)
            } catch {
                print("Error decoding data \(error)")
            }
        }
    }
}

