//
//  File.swift
//  
//
//  Created by Dennis Hernandez on 9/6/21.
// Moved Vapor to it's own controller for tidiness

import Vapor

public class VaporController {
    
    var env: Environment?
    var app: Application?
    
    public init() {
    }
    
    public func startVapor() {
        do {
            env = try Environment.detect()
            try LoggingSystem.bootstrap(from: &env!)
            app = Application(env!)
            defer { app!.shutdown() }
            try configure(app!)
            try app!.run()
        } catch {
            env = nil
            app = nil
            print("Vapor Init Error")
            return
        }
    }
    
    func stopVapor() {
        app!.shutdown()
        app = nil
        env = nil
        }
}
