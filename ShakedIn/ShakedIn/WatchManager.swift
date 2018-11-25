//
//  WatchManager.swift
//  ShakedIn
//
//  Created by Nafeh Shoaib on 2018-11-25.
//  Copyright © 2018 nafehshoaib. All rights reserved.
//

import WatchConnectivity

class WatchSessionManager: NSObject, WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    
    static let sharedManager = WatchSessionManager()
    static var sharedConnections: [String] = []
    
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default : nil
    private var validSession: WCSession? {
        if let session = session, session.isPaired && session.isWatchAppInstalled {
            return session
        }
        return nil
    }
    
    
    func startSession() {
        session?.delegate = self
        session?.activate()
        
    }
    
    func sessionWatchStateDidChange(_ session: WCSession) {
        if session.activationState == .activated {
            updateApplicationContext()
        }
    }
    
    // Construct and send the updated application context to the watch.
    func updateApplicationContext() {
        let context = [String: AnyObject]()
        
        // Now, compute the values from your model object to send to the watch.
        do {
            try WatchSessionManager.sharedManager.updateApplicationContext(applicationContext: context)
        } catch {
            print("Error updating application context")
        }
    }
    
}

// MARK: Application Context
extension WatchSessionManager {
    
    // Sender
    func updateApplicationContext(applicationContext: [String : AnyObject]) throws {
        if let session = validSession {
            do {
                try session.updateApplicationContext(applicationContext)
            } catch let error {
                throw error
            }
        }
    }
    
}


// MARK: Interactive Messaging
extension WatchSessionManager {
    
    private var validReachableSession: WCSession? {
        if let session = validSession, session.isReachable {
            return session
        }
        return nil
    }
    
    // Receiver
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject],
                 replyHandler: ([String : AnyObject]) -> Void) {
        if message["isShaking"] as! Bool == true {
            
        }
//        if message[Key.Request.ApplicationContext] != nil {
//            updateApplicationContext()
//        }
    }
    
}
