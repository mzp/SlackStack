//
//  ViewController.swift
//  Slackdeck
//
//  Created by mzp on 2017/04/29.
//  Copyright © 2017 mzp. All rights reserved.
//

import Cocoa
import WebKit
import NorthLayout

class ViewController: NSViewController {
    private var webView : WKWebView?

    override func loadView() {
        if let frame = NSScreen.main()?.frame {
            self.view = NSView(frame: NSMakeRect(0, 0, frame.width * 0.8, frame.height * 0.8))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)

        let autolayout = view.northLayoutFormat([:], [
            "webView" :  webView!
        ])
        autolayout("V:|[webView]|")
        autolayout("H:|[webView]|")

        // spoof useragent to skip slack check
        webView?.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"
        let url = URL(string: "https://misoca-inc.slack.com")
        let request = URLRequest(url: url!)
        webView?.load(request)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

