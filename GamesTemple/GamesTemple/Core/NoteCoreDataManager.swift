//
//  NoteCoreDataManager.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 14.12.2022.
//

import Foundation
import UIKit
import CoreData

final class NoteCoreDataManager {
    static let shared = NoteCoreDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveNote(rating:Double, gameImage:String, gameName:String,header:String,noteText:String) -> Note? {
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        note.setValue(rating, forKey: "rating")
        note.setValue(gameImage, forKey: "gameImage")
        note.setValue(gameName, forKey: "gameName")
        note.setValue(header, forKey: "header")
        note.setValue(noteText, forKey: "noteText")
        
        do {
           try managedContext.save()
            return note as? Note
        } catch {
            print("Error")
        }
        return nil
    }
   
    
    func getNote() -> [Note] {
       let fetch = NSFetchRequest<NSManagedObject>(entityName: "Note")
        fetch.returnsObjectsAsFaults = false
        do {
            let notes = try managedContext.fetch(fetch)
            return notes as! [Note]
        } catch {
            print("Error")
        }
        return []
    }
}
