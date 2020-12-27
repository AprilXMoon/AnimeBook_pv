//
//  FavoriteViewModel.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/21.
//

import Foundation
import CoreData

class FavoriteViewModel {
    var items: [FavoriteItem] = []
    
    func loadData(type: DataType) {
        if type == .anime {
            items = CoreDataManager.shared.fetchFavoriteAnime() ?? []
        } else if type == .manga {
            items = CoreDataManager.shared.fetchFavoriteManga() ?? []
        }
    }
    
    func deleteFavoriteItem(itemID: Int) -> Bool {
        return CoreDataManager.shared.deleteFavoriteItem(itemId: itemID)
    }
    
}
