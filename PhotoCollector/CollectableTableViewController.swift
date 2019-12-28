//
//  CollectableTableViewController.swift
//  PhotoCollector
//
//  Created by Dilmurod Ubaydullaev on 12/28/19.
//  Copyright © 2019 Dilmurod Ubaydullaev. All rights reserved.
//

import UIKit
import CoreData

class CollectableTableViewController: UITableViewController {
    
    var collectablesTitle : Array<String> = Array()
    var collectablesData : Array<Data> = Array()

    override func viewWillAppear(_ animated: Bool) {
        getCollectables()
    }
    
    func getCollectables(){
        collectablesTitle.removeAll()
        collectablesData.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Collectable")
        do{
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]{
                collectablesTitle.append(data.value(forKey: "title") as! String)
                collectablesData.append(data.value(forKey: "image") as! Data)
            }
        }
        catch{
            print("Failed")
        }
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collectablesTitle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = collectablesTitle[indexPath.row]
        cell.imageView?.image = UIImage(data: collectablesData[indexPath.row])

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            let title = collectablesTitle[indexPath.row]
            let imageData = collectablesData[indexPath.row]
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Collectable")
            do{
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject]{
                    if(data.value(forKey: "title") as! String == title && data.value(forKey: "image") as! Data == imageData){
                        context.delete(data)
                    }
                }
                
            }
            catch{
                print("Failed")
            }
            
            appDelegate.saveContext()
            getCollectables()
            
        }
    }
    
}
