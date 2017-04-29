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

    // MARK: channel
    func addChannel() {
        self.channels.append(SlackChannelView(configuration: configuration) ※ { wk in
            wk.loadURL(url: "https://misoca-inc.slack.com")
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
        view.subviews.forEach { $0.removeFromSuperview() }

        switch channels.count {
        case 1:
            let autolayout = view.northLayoutFormat([:], [
                "c0": channels[0]
                ])
            autolayout("V:|[c0]|")
            autolayout("H:|[c0]|")
        case 2:
            let autolayout = view.northLayoutFormat([:], [
                "c0": channels[0],
                "c1": channels[1]
                ])
            autolayout("V:|[c0]|")
            autolayout("V:|[c1]|")
            autolayout("H:|[c0][c1(==c0)]|")
        case 3:
            let autolayout = view.northLayoutFormat([:], [
                "c0": channels[0],
                "c1": channels[1],
                "c2": channels[2]
                ])
            autolayout("V:|[c0]|")
            autolayout("V:|[c1]|")
            autolayout("V:|[c2]|")
            autolayout("H:|[c0][c1(==c0)][c2(==c0)]|")
        default:
            ()
        }
    }
}
