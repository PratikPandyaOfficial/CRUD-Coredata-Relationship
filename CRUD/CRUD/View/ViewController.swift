//
//  ViewController.swift
//  CRUD
//
//  Created by Pratik Pandya on 25/03/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tbl: UITableView!
    
    var items:[Person]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        reloadData()
    }
    
    
    func reloadData(){
        items = coredata().getData()
        DispatchQueue.main.async {
            self.tbl.reloadData()
        }
    }
    
    @IBAction func addPerson(_ sender: Any) {
        
        let alert = UIAlertController(title: "Add Person", message: "What's the name?", preferredStyle: .alert)
        
        alert.addTextField()
        
        let submit = UIAlertAction(title: "Add", style: .default){ (action) in
            let textField = alert.textFields![0]
            
            coredata().addData(data: textField.text ?? "")
            coredata().saveData()
            self.reloadData()
        }
        
        alert.addAction(submit)
        
        self.present(alert, animated: true)
        
    }
    

}
extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell") as? tblCell else { return UITableViewCell() }
        
        cell.lblName.text = self.items?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person =  self.items![indexPath.row]
        
        let alert = UIAlertController(title: "Rename Person", message: "What's the new name?", preferredStyle: .alert)
        
        alert.addTextField()
        let textField = alert.textFields![0]
        textField.text = person.name
        
        let submit = UIAlertAction(title: "Rename", style: .default){ (action) in
            
            coredata().updateData(data: person, text: textField.text ?? "")
            coredata().saveData()
            self.reloadData()
            
        }
        
        alert.addAction(submit)
        
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
            let personToRemove = self.items![indexPath.row]
            
            coredata().deleteData(dataToRemove: personToRemove)
            coredata().saveData()
            self.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

