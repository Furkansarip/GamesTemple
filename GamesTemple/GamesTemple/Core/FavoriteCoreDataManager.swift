//
//  CoreDataManager.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 12.12.2022.
//


import UIKit
import CoreData

final class FavoriteCoreDataManager {
    static let shared = FavoriteCoreDataManager()
    let managedContext : NSManagedObjectContext!
    public init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
        
    }
    
    func saveGame(gameName:String,gameImage:String,id:String) -> FavoriteGame? {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteGame", in: managedContext)!
        let favoriteGame = NSManagedObject(entity: entity, insertInto: managedContext)
        favoriteGame.setValue(gameImage, forKey: "image")
        favoriteGame.setValue(gameName, forKey: "name")
        favoriteGame.setValue(id, forKey: "gamesId")
        do {
            try managedContext.save()
            return favoriteGame as? FavoriteGame
        } catch {
            print("Error")
        }
        return nil
    }
    
    func deleteFavoriteGame(name:String){
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
        fetch.predicate = NSPredicate(format: "name = %@", name)
        fetch.returnsObjectsAsFaults = false
        
        do {
            let deleteGame = try managedContext.fetch(fetch)
            for game in deleteGame {
                if let _ = game.value(forKey: "name") {
                    managedContext.delete(game)
                    do  {
                        try managedContext.save()
                    } catch {
                        print("Catch: FavouritesVC.swift : NSManagedObject")
                    }
                    break
                }
            }
        } catch {
            print("Error")
        }
        
    }
    
    func getFavoriteGame() -> [FavoriteGame] {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "FavoriteGame")
        do {
            let favoriteGame = try managedContext.fetch(fetch)
            return favoriteGame as! [FavoriteGame]
        } catch {
            print("Error")
        }
        return []
    }
}
