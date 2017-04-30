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
import Ikemen

fileprivate let configuration = WKWebViewConfiguration()

class ViewController: NSViewController {
    private var channels : [SlackChannelView] = []
    private let stackView = NSStackView()

    override func loadView() {
        if let frame = NSScreen.main()?.frame {
            self.view = NSView(frame: NSMakeRect(0, 0, frame.width * 0.8, frame.height * 0.8))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        channels = Prefercences.urls.map { url in
            SlackChannelView(configuration: configuration) ※ { wk in
                wk.loadURL(url: url)
            }
        }
    }

    override func viewDidAppear() {
        stackView.spacing = 0.0
        stackView.distribution = .fillEqually
        let autolayout = view.northLayoutFormat([:], [
            "stack": stackView
        ])
        autolayout("V:|[stack]|")
        autolayout("H:|[stack]|")
        showChannels()
    }

    override func viewWillDisappear() {
        Prefercences.urls = channels.flatMap({ channel in
            channel.url?.absoluteString
        })
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - channel
    func addChannel() {
        self.channels.append(SlackChannelView(configuration: configuration) ※ { wk in
            wk.loadURL(url: defaultUrl)
        })
        showChannels()
    }

    func removeChannel(responder : NSResponder) {
        self.channels = channels.filter { ch in
            ch != responder
        }
        showChannels()
    }

    private func showChannels() {
        stackView.setViews(channels, in: .leading)
    }

    // MARK: - URL
    private var defaultUrl : String {
        get{
            return self.channels.first?.url?.absoluteString ?? "https://slack.com"
        }
    }
}
