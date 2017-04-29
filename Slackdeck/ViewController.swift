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

fileprivate let configuration = WKWebViewConfiguration()

class ViewController: NSViewController {
    private lazy var left = SlackChannelView(configuration: configuration)
    private lazy var right = SlackChannelView(configuration: configuration)

    override func loadView() {
        if let frame = NSScreen.main()?.frame {
            self.view = NSView(frame: NSMakeRect(0, 0, frame.width * 0.8, frame.height * 0.8))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear() {
        let autolayout = view.northLayoutFormat([:], [
            "left" : left,
            "right": right
        ])
        autolayout("V:|[left]|")
        autolayout("V:|[right]|")
        autolayout("H:|[left][right(==left)]|")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

