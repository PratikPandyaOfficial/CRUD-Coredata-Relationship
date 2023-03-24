//
//  Extension.swift
//  CRUD
//
//  Created by Pratik Pandya on 25/03/23.
//

import Foundation
import UIKit
import CoreData

class coredata {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(){
        do{
            try self.context.save()
        }
        catch let error{
            print(error)
        }
    }
    
    func getData() -> [Person]{ //className_CoreDataClass.swift
//        do {
            
            let request = Person.fetchRequest() as NSFetchRequest<Person>
            //Filter on Name for search
            //let pred = NSPredicate(format: "name CONTAINS %@", "Test")
            //request.predicate = pred
            
            //Sort data in ascending order
            //let sort = NSSortDescriptor(key: "name", ascending: true)
            //request.sortDescriptors = [sort]
            
            
            return try! context.fetch(request)
            //Just to avoid try we have done this but this is not ideal.
        
        
        
            //self.items = try context.fetch(Person.fetchRequest())
            // for all data
//        }
//        catch let error{
//            print(error)
//        }
    }
    
    func addData(data:String){
        let newPerson = Person(context: self.context)
        newPerson.name = data
        newPerson.age = 20
    }
    
    func updateData(data:Person, text:String){
        let person =  data
        person.name = text
        person.age = 20
    }
    
    func deleteData(dataToRemove:Person){
        self.context.delete(dataToRemove)
    }
    
    func realtionship(){
        //Create a family
        let family = Family(context: context)
        family.name = "Abc family"
        //Create a person
        let person = Person(context: context)
        person.name = "Maggie"
        //person.family
        
        //Add person to family
        family.addToPeople(person)
        
        //Save
        do{
            try self.context.save()
        }
        catch let error{
            print(error)
        }
    }
}
