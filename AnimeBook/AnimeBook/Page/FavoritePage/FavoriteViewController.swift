//
//  FavoriteViewController.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/18.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    private var type: DataType = .anime
    let viewModel: FavoriteViewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData(type: type)
        typeButton.setTitle(type.rawValue, for: .normal)
        favoriteTableView.isHidden = (viewModel.items.count == 0)
        favoriteTableView.reloadData()
    }
    
    private func setupTableView() {
        favoriteTableView.dataSource = self
        favoriteTableView.delegate = self
        
        favoriteTableView.register(UINib(nibName: TopListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TopListCell.reuseIdentifier)
    }
    
    @IBAction func typeButtonDidPressed(_ sender: Any) {
        let selectView = SelectViewController()
        selectView.type = type
        selectView.selectType = .favorite
        selectView.modalPresentationStyle = .fullScreen
        selectView.delegate = self
        
        navigationController?.pushViewController(selectView, animated: true)
    }
}

// MARK: - SelectViewControllerDelegate
extension FavoriteViewController: SelectViewControllerDelegate {
    
    func selectedDatatype(type: String) {
        viewModel.items.removeAll()
        self.type = DataType(rawValue: type) ?? .anime
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.item]
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopListCell.reuseIdentifier, for: indexPath) as? TopListCell {
            cell.setupCellByFavoriteItem(item: item)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        
        let detailWebView = WebViewController()
        detailWebView.url = item.detailURL ?? ""
        detailWebView.title = item.title
        
        navigationController?.pushViewController(detailWebView, animated: true)
    }
}

// MARK: - TopListCellDelegate
extension FavoriteViewController: TopListCellDelegate {
    func favoriteButtonDidPressed(isSelected: Bool, selectedIndex: Int) {
        let item = viewModel.items[selectedIndex]
        let favoriteResult = viewModel.deleteFavoriteItem(itemID: Int(item.malID))
        if favoriteResult {
            favoriteTableView.reloadData()
        } else {
            AlertHelper.showAlertWithOKAction(ownerVC: self, title: "Error", message: "Delete favorite fail, Please try again later.")
            print("[Error] delete favorite fail")
        }
        
    }
}
