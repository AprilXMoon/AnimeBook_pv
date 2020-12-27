//
//  IndicatorViewManager.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import Foundation
import UIKit

class IndicatorViewManager {
    
    private static var instance: IndicatorViewManager!
    
    public static var shared: IndicatorViewManager {
        if instance == nil {
            instance = IndicatorViewManager()
            instance.indicatorView.style = .large
        }
        return instance
    }
    
    private let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

    func setupOwner(owner: UIViewController) {
        
        indicatorView.center = owner.view.center
        owner.view.addSubview(indicatorView)
        owner.view.bringSubviewToFront(indicatorView)
    }
    
    func start() {
        indicatorView.startAnimating()
    }
    
    func stop() {
        indicatorView.stopAnimating()
        indicatorView.hidesWhenStopped = true
    }
}
