//
//  SelectViewController.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import UIKit

protocol SelectViewControllerDelegate {
    func selectedAnimeSubtype(subtype: AnimeSubtype)
    func selectedMangaSubtype(subtype: MangaSubtype)
    func selectedDatatype(type: String)
}

extension SelectViewControllerDelegate {
    func selectedAnimeSubtype(subtype: AnimeSubtype) {}
    func selectedMangaSubtype(subtype: MangaSubtype) {}
    func selectedDatatype(type: String) {}
}

class SelectViewController: UIViewController {
    
    private let itemTableView: UITableView = UITableView(frame:CGRect.zero, style:.plain)
    
    var type: DataType = .none
    var selectType: SelectType = .list
    let viewModel = SelectViewModel()
    
    var delegate: SelectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadData(selectType: selectType, type: type)
        setupTableView()
    }

    private func setupTableView() {
        
        itemTableView.frame = view.frame
        self.view.addSubview(itemTableView)
        
        itemTableView.dataSource = self
        itemTableView.delegate = self
        
        itemTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ItemCell")
    }
}

// MARK: - UITableViewDataSource
extension SelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.items[indexPath.item]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = item
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        if selectType == .favorite {
            delegate?.selectedDatatype(type: item)
        } else {
            switch type {
            case .anime:
                delegate?.selectedAnimeSubtype(subtype: AnimeSubtype(rawValue: item.lowercased()) ?? .airing)
            case .manga:
                delegate?.selectedMangaSubtype(subtype: MangaSubtype(rawValue: item.lowercased()) ?? .manga)
            default:
                break
            }
        }
        
        navigationController?.popViewController(animated: true)
    }
}
