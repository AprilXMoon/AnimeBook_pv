//
//  CoreDataManager.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    private static var instance: CoreDataManager!
    
    public static var shared: CoreDataManager {
        if instance == nil {
            instance = CoreDataManager()
        }
        return instance
    }
    
    private let favoriteItem = "FavoriteItem"
    
    // 用來操作 Core Data 的常數
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // fetch
    
    func fetchFavoriteAnime() -> [FavoriteItem]? {
        return fetchFavoriteItem(predicate: "groupType == \"anime\"")
    }
    
    func fetchFavoriteManga() -> [FavoriteItem]? {
        return fetchFavoriteItem(predicate: "groupType == \"manga\"")
    }
    
    private func fetchFavoriteItem(predicate: String) -> [FavoriteItem]? {
        let request: NSFetchRequest<FavoriteItem> = FavoriteItem.fetchRequest()
        request.predicate = NSPredicate(format: predicate)
        request.sortDescriptors = [NSSortDescriptor(key: "rank", ascending: true)]
        
        do {
            let results = try moc.fetch(request)
            return results
        } catch {
            print("[Error] \(#function) fail")
        }
        return nil
    }
    
    // create insert data
    private func createInsertData(item: TopItem, groupType: String) -> [String: String] {
        var data = ["malID": String(item.malID),
                    "title": item.title,
                    "rank": String(item.rank),
                    "itemType": item.type,
                    "groupType": groupType,
                    "imageURL": item.imageURL,
                    "detailURL": item.url]
        
        if let startDate = item.startDate {
            data.updateValue(startDate, forKey: "startDate")
        }
        if let endDate = item.endDate {
            data.updateValue(endDate, forKey: "endDate")
        }
        
        return data
    }
    
    // insert
    func insertFavoriteItem(item: TopItem, groupType: String) -> Bool {
        
        let attributeInfo = createInsertData(item: item, groupType: groupType)
        let insertData = NSEntityDescription.insertNewObject(forEntityName: favoriteItem, into: moc) as! FavoriteItem
        
        for (key, value) in attributeInfo {
            let rowType = insertData.entity.attributesByName[key]?.attributeType
            
            if rowType == .integer32AttributeType {
                insertData.setValue(Int(value), forKey: key)
            } else {
                insertData.setValue(value, forKey: key)
            }
        }
        
        do {
            try moc.save()
            return true
        } catch {
            print("[Error] \(#function) fail")
        }
        return false
    }
    
   
    // delete
    func deleteFavoriteItem(itemId: Int) -> Bool {
        let predicate = "malID = \(itemId)"
        if let results = fetchFavoriteItem(predicate: predicate) {
            for result in results {
                moc.delete(result)
                return true
            }
            
            do {
                try moc.save()
            } catch {
                print("[Error] \(#function) fail")
            }
        }
        return false
    }
    
}


