//
//  SlackChannelView.swift
//  Slackdeck
//
//  Created by mzp on 2017/04/29.
//  Copyright © 2017 mzp. All rights reserved.
//

import Cocoa
import WebKit

class SlackChannelView: WKWebView {
    init(configuration : WKWebViewConfiguration) {
        super.init(frame: .zero, configuration: configuration)
        self.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4"

        // FIXME: this is example page
        if let url = URL(string: "https://misoca-inc.slack.com") {
            let request = URLRequest(url: url)
            self.load(request)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
