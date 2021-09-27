//
//  TopListViewController.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/18.
//

import UIKit

class TopListViewController: UIViewController, APIProtocol {

    @IBOutlet weak var topListTableView: UITableView!
    @IBOutlet weak var subtypeButton: UIButton!
    
    var type: DataType = .none
    var viewModel: TopListViewModel = TopListViewModel()
    private var isloading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupTableView()
        setupSubtypeButtonTitle(type: type)
        startIndicator()
        loadData()
    }
    
    private func startIndicator() {
        IndicatorViewManager.shared.setupOwner(owner: self)
        IndicatorViewManager.shared.start()
    }
   
    private func loadData() {
        isloading = true
        viewModel.loadData()
    }
    
    private func setupViewModel() {
        viewModel = TopListViewModel()
        viewModel.type = type
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        
        topListTableView.isHidden = true
        
        topListTableView.dataSource = self
        topListTableView.delegate = self
        
        topListTableView.register(UINib(nibName: TopListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: TopListCell.reuseIdentifier)
    }
    
    private func setupSubtypeButtonTitle(type: DataType) {
        
        if type == .anime {
            subtypeButton.setTitle(viewModel.animeSubtype.rawValue.uppercased(), for: .normal)
        } else if type == .manga {
            subtypeButton.setTitle(viewModel.mangaSubtype.rawValue.uppercased(), for: .normal)
        } else {
            subtypeButton.setTitle("SUBTYPE", for: .normal)
        }
    }
    
    private func reloadDataByChangedSubtype() {
        viewModel.items.removeAll()
        viewModel.page = 1
        startIndicator()
        loadData()
        setupSubtypeButtonTitle(type: type)
    }
    
    @IBAction func subtypeButtonDidPressed(_ sender: Any) {
        let selectView = SelectViewController()
        selectView.type = type
        selectView.modalPresentationStyle = .fullScreen
        selectView.delegate = self
        
        navigationController?.pushViewController(selectView, animated: true)
    }
}

// MARK: - SelectViewControllerDelegate
extension TopListViewController: SelectViewControllerDelegate {
    func selectedAnimeSubtype(subtype: AnimeSubtype) {
        viewModel.animeSubtype = subtype
        reloadDataByChangedSubtype()
    }
    
    func selectedMangaSubtype(subtype: MangaSubtype) {
        viewModel.mangaSubtype = subtype
        reloadDataByChangedSubtype()
    }
}

// MARK: - TopListViewModelDelegate
extension TopListViewController: TopListViewModelDelegate {
    func loadAPIError(error: Error?) {
        AlertHelper.showAlertWithOKAction(ownerVC: self, title: "Error", message: error?.localizedDescription)
    }
    
    func reloadPage() {
        IndicatorViewManager.shared.stop()
        isloading = false
        topListTableView.isHidden = false
        topListTableView.reloadData()
    }
}

// MARK: - UIScrollViewDelegate
extension TopListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isloading &&
           (scrollView.contentOffset.y + scrollView.frame.height) > topListTableView.contentSize.height * 0.8 {
            isloading = true
            viewModel.page += 1
            viewModel.loadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension TopListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.item]
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopListCell.reuseIdentifier, for: indexPath) as? TopListCell {
            cell.settingCell(item: item)
            cell.index = indexPath.item
            cell.delegate = self
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension TopListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        
        let detailWebView = WebViewController()
        detailWebView.url = item.url
        detailWebView.title = item.title
        
        navigationController?.pushViewController(detailWebView, animated: true)
    }
}

// MARK: - TopListCellDelegate
extension TopListViewController: TopListCellDelegate {
    func favoriteButtonDidPressed(isSelected: Bool, selectedIndex: Int) {
        let favoriteResult = viewModel.setFavoriteitem(isFavorite: isSelected, index: selectedIndex)
        if favoriteResult {
            topListTableView.reloadData()
        } else {
            let message = isSelected ? "Insert favorite fail" : "Delete favorite fail"
            AlertHelper.showAlertWithOKAction(ownerVC: self, title: "Error", message: "\(message), Please try again later.")
            print("[Error] set favorite fail")
        }
        
    }
}
