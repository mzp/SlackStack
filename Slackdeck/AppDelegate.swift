//
//  AppDelegate.swift
//  Slackdeck
//
//  Created by mzp on 2017/04/29.
//  Copyright © 2017 mzp. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet weak var window : NSWindow!
    private var rootViewController : ViewController {
        get{
            return window.contentViewController as! ViewController
        }
    }


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.title = "Slackdeck"
        window.contentViewController = ViewController(nibName: nil, bundle: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func removeChannel(_ sender: Any) {
        rootViewController.removeChannel(responder: window.firstResponder)
    }

    @IBAction func addChannel(_ sender: Any) {
        rootViewController.addChannel()
    }

    @IBAction func logout(_ sender: Any) {
    }
}

