//
//  WebViewController.swift
//  AnimeBook
//
//  Created by April Lee on 2020/12/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private let webView: WKWebView = WKWebView()
    var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = view.frame
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    
        loadURL()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IndicatorViewManager.shared.setupOwner(owner: self)
        IndicatorViewManager.shared.start()
    }
    
    private func loadURL() {
        guard !url.isEmpty,
              let detailURL = URL(string: url) else {
            return
        }
        
        let request = URLRequest(url: detailURL)
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        IndicatorViewManager.shared.stop()
    }
}
