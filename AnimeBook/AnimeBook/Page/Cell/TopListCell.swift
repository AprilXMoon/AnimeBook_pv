//
//  TopListCell.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import UIKit
import SDWebImage

protocol TopListCellDelegate {
    func favoriteButtonDidPressed(isSelected: Bool, selectedIndex: Int)
}

class TopListCell: UITableViewCell {
    
    static let reuseIdentifier = "TopListCell"

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var index: Int = 0
    var delegate: TopListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        rank.text = ""
        title.text = ""
        type.text = ""
        startDate.text = ""
        endDate.text = ""
        itemImage.image = nil
        favoriteButton.isSelected = false
    }
    
    func settingCell(item: TopItem) {
        rank.text = String(item.rank)
        title.text = item.title
        type.text = item.type
        startDate.text = item.startDate
        endDate.text = item.endDate
        itemImage.sd_setImage(with: URL(string: item.imageURL), completed: nil)
        favoriteButton.isSelected = item.isFavorited
    }
    
    func setupCellByFavoriteItem(item: FavoriteItem) {
        rank.text = String(item.rank)
        title.text = item.title
        type.text = item.itemType
        startDate.text = item.startDate
        endDate.text = item.endDate
        if let imageURL = item.imageURL {
            itemImage.sd_setImage(with: URL(string: imageURL), completed: nil)
        }
        favoriteButton.isSelected = true
    }
    
    @IBAction func favoriteButtonDidPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.favoriteButtonDidPressed(isSelected: sender.isSelected, selectedIndex: index)
    }
}
