//
//  TopListViewModel.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import Foundation

enum DataType: String, CaseIterable {
    case none = "NONE"
    case anime = "ANIME"
    case manga = "MANGA"
}

protocol TopListViewModelDelegate {
    func reloadPage()
    func loadAPIError(error: Error?)
}

class TopListViewModel: APIProtocol {
    
    var type: DataType = .none
    var items: [TopItem] = []
    var page: Int = 1
    var animeSubtype: AnimeSubtype = .airing
    var mangaSubtype: MangaSubtype = .manga
    
    var delegate: TopListViewModelDelegate?
    
    func clearItems() {
        items.removeAll()
    }
    
    func loadData() {
        switch type {
        case .anime:
            loadAnimeData()
        case .manga:
            loadMangaData()
        default:
            break
        }
    }
    
    func setFavoriteitem(isFavorite: Bool, index: Int) -> Bool {
        let item = items[index]
        
        if isFavorite {
            let isSuccess = CoreDataManager.shared.insertFavoriteItem(item: item, groupType: type.rawValue.lowercased())
            if isSuccess {
                items[index].isFavorited = true
            }
            return isSuccess
        } else {
            let isSuccess = CoreDataManager.shared.deleteFavoriteItem(itemId: item.malID)
            if isSuccess {
                items[index].isFavorited = false
            }
            return isSuccess
        }
    }
    
    private func loadAnimeData() {
        fetchTopAnimeData(page: page, subtype: animeSubtype) { (result) in
            switch result {
            case .success(let topData):
                self.items += topData.topItems
                self.setFavoriteItem()
                self.delegate?.reloadPage()
            case .failure(let error):
                self.delegate?.loadAPIError(error: error)
                print(error)
            }
        }
    }
    
    private func setFavoriteItem() {
        guard let favoriteItems = CoreDataManager.shared.fetchFavoriteAnime() else {
            return
        }
        for (index, element) in items.enumerated() {
            let favoriteItem = favoriteItems.contains{ $0.malID == element.malID }
            if favoriteItem {
                items[index].isFavorited = true
            }
        }
    }
    
    private func loadMangaData() {
        fetchTopMangaData(page: page, subtype: mangaSubtype) { (result) in
            switch result {
            case .success(let topData):
                self.items += topData.topItems
                self.delegate?.reloadPage()
            case .failure(let error):
                self.delegate?.loadAPIError(error: error)
                print(error)
            }
        }
    }
}
