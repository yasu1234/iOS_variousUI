//
//  WebViewController.swift
//  swift_variousUI
//
//  Created by kuma on 2024/02/15.
//  Copyright © 2024 kuma. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private enum WebViewProperty: String, CaseIterable {
        case url = "URL"
        case loading = "loading"
        case title = "title"
    }
    
    @IBOutlet private weak var webViewContainer: UIView!
    
    private var webView: WKWebView!
    private var initialUrl: String = ""
    private var progressView = UIProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        for property in WebViewProperty.allCases {
            webView.removeObserver(
                self,
                forKeyPath: property.rawValue,
                context: nil
            )
        }
        
        webView = nil
    }
}

// MARK: - UI

extension WebViewController {
    private func setupUI() {
        setupWebView()
        loadUrl()
    }
    
    private func loadUrl() {
        if let url = URL(string: initialUrl) {
            let request = URLRequest(url: url)
            webView.load(request as URLRequest)
        }
    }
    
    private func setupWebView() {
        let userContentController = WKUserContentController()
        let webConfiguration = WKWebViewConfiguration()
        
        let customFrame = CGRect(
            origin: CGPoint.zero,
            size: webViewContainer.frame.size
        )
        
        webConfiguration.userContentController = userContentController
        
        webView = WKWebView(frame: customFrame, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.backgroundColor = .clear
        
        webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
        
        for property in WebViewProperty.allCases {
            webView.addObserver(
                self,
                forKeyPath: property.rawValue,
                options: .new,
                context: nil
            )
        }
    }
    
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?) {
            guard let keyPath = keyPath,
                  let property = WebViewProperty(rawValue: keyPath) else {
                return
            }
            
            switch property {
            case .url:
                break
            case .title:
                title = webView.title
            case .loading:
                refreshProgressVisivility()
            }
    }
    
    private func refreshProgressVisivility() {
        progressView.setProgress(
            webView.isLoading ? 1.0 : 0.0,
            animated: webView.isLoading
        )
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // if you want to strict url, then use decisionHandler(.cancel)
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let url = navigationAction.request.url else {
            return nil
        }
        
        guard let targetFrame = navigationAction.targetFrame,
              targetFrame.isMainFrame else {
            webView.load(URLRequest(url: url))
            return nil
        }
        
        return nil
    }
}

extension WebViewController: StoryboardInstance {
    static func newInstance(_ urlString: String) -> WebViewController {
        let controller = UIStoryboard(
            name:WebViewController.storyboardName(),
            bundle: nil
        ).instantiateViewController(
            withIdentifier: WebViewController.identifer()
        ) as! WebViewController
        
        controller.initialUrl = urlString
        
        return controller
    }
    
    static func storyboardName() -> String {
        return "Web"
    }
    
    static func identifer() -> String {
        return String(describing: WebViewController.self)
    }
}
