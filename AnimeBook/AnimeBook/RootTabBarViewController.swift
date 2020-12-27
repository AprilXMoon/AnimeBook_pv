//
//  RootTabBarViewController.swift
//  AnimeBook
//
//  Created by Apple LEE on 2020/12/18.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTabItems()
    }
    
    private func createTabItems() {
        let animePage = TopListViewController(nibName: "TopListViewController", bundle: nil)
        animePage.type = .anime
        animePage.title = "Anime"
        let animeNavigationController = UINavigationController(rootViewController: animePage)
        animeNavigationController.tabBarItem = UITabBarItem(title: "Anime", image: UIImage(systemName: "play.rectangle"), selectedImage: UIImage(systemName: "play.rectangle.fill"))
        
        let mangaPage = TopListViewController(nibName: "TopListViewController", bundle: nil)
        mangaPage.type = .manga
        mangaPage.title = "Manga"
        let mangaNavigationController = UINavigationController(rootViewController: mangaPage)
        mangaNavigationController.tabBarItem = UITabBarItem(title: "Manga", image: UIImage(systemName: "book.closed"), selectedImage: UIImage(systemName: "book.closed.fill"))
        
        let favoritePage = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        favoritePage.title = "Favorite"
        let favoriteNavigationController = UINavigationController(rootViewController: favoritePage)
        favoriteNavigationController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        viewControllers = [animeNavigationController, mangaNavigationController, favoriteNavigationController]
    }

}
