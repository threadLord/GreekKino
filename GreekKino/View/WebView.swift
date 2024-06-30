//
//  WebView.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI
import WebKit

struct SwiftUIWebView: UIViewRepresentable {
    
    typealias UIViewType = WKWebView
    
    let webView: WKWebView =  WKWebView(frame: .zero)
    
    init(url: String) {
        load(url: url)
    }
    
    func load(url: String) {
        if let url = URL(string: url) {
            DispatchQueue.main.async {
                webView.load(URLRequest(url: url))
            }
        }
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
