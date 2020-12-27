//
//  FavoriteItem+CoreDataProperties.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/24.
//
//

import Foundation
import CoreData


extension FavoriteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteItem> {
        return NSFetchRequest<FavoriteItem>(entityName: "FavoriteItem")
    }

    @NSManaged public var detailURL: String?
    @NSManaged public var endDate: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var itemType: String?
    @NSManaged public var malID: Int32
    @NSManaged public var startDate: String?
    @NSManaged public var groupType: String?
    @NSManaged public var title: String?
    @NSManaged public var rank: Int32

}

extension FavoriteItem : Identifiable {

}
