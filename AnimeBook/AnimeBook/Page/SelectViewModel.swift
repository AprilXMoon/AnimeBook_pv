//
//  SelectViewModel.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import Foundation

enum SelectType {
    case list, favorite
}

class SelectViewModel {
    
    var items: [String] = []
    
    func loadData(selectType: SelectType, type: DataType) {
        if selectType == .favorite {
            loadFavoriteItem()
        } else {
            loadListItem(type: type)
        }
    }
    
    private func loadFavoriteItem() {
        items = DataType.allCases.filter{ $0 != .none}.map{ $0.rawValue }
    }
    
    private func loadListItem(type: DataType) {
        switch type {
        case .anime:
            items = AnimeSubtype.allCases.map{ $0.rawValue.uppercased() }
        case .manga:
            items = MangaSubtype.allCases.map{ $0.rawValue.uppercased() }
        default:
            break
        }
    }
}
