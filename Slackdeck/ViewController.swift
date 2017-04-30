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
    private var channels : [[SlackChannelView]] = []
    private let stackView = NSStackView() ※ { sv in
        sv.spacing = 0.0
        sv.distribution = .fillEqually
        sv.orientation = .vertical
    }

    override func loadView() {
        if let frame = NSScreen.main()?.frame {
            self.view = NSView(frame: NSMakeRect(0, 0, frame.width * 0.8, frame.height * 0.8))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        channels = Prefercences.urls.map { row in
            row.flatMap { url in
                SlackChannelView(configuration: configuration) ※ { wk in
                    wk.loadURL(url: url)
                }
            }
        }
    }

    override func viewDidAppear() {
        let autolayout = view.northLayoutFormat([:], [
            "stack": stackView
        ])
        autolayout("V:|[stack]|")
        autolayout("H:|[stack]|")
        showChannels()
    }

    override func viewWillDisappear() {
        Prefercences.urls = channels.map { row in
            row.flatMap { ch in ch.url?.absoluteString }
        }
    }

    // MARK: - channel
    func addChannel(responder : NSResponder) {
        guard let wk = responder as? SlackChannelView else { return }
        guard let n = self.channels.index(where: { $0.contains(wk) }) else { return }

        channels[n].append(SlackChannelView(configuration: configuration) ※ { wk in
            wk.loadURL(url: defaultUrl)
        })
        showChannels()
    }

    func removeChannel(responder : NSResponder) {
        self.channels = channels.map { row in
            row.filter { $0 != responder }
        }
        showChannels()
    }

    // MARK: - row
    func addRow() {
        let channel = SlackChannelView(configuration: configuration) ※ { wk in
            wk.loadURL(url: defaultUrl)
        }
        self.channels.append([channel])
        showChannels()
    }

    func removeRow(responder : NSResponder) {
        guard let wk = responder as? SlackChannelView else { return }
        self.channels = self.channels.filter { !$0.contains(wk) }
        showChannels()
    }

    // MARK: - view
    private func showChannels() {
        let views = channels.map { row in
            NSStackView() ※ { sv in
                sv.spacing = 0.0
                sv.distribution = .fillEqually
                sv.setViews(row, in: .leading)
            }
        }
        stackView.setViews(views, in: .leading)
    }

    // MARK: - URL
    private var defaultUrl : String {
        get {
            return "https://misoca-inc.slack.com"
        }
    }
}
