//
//  AlertHelper.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/27.
//

import Foundation
import UIKit

class AlertHelper {
    
    static func showAlertWithOKAction(ownerVC: UIViewController, title: String? = nil, message: String? = nil) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertView.addAction(okAction)
        ownerVC.present(alertView, animated: true, completion: nil)
    }
}
