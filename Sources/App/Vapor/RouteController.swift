//
//
//  
//
//  Created by Dennis Hernandez on 8/22/21.
//

import Vapor

struct RouteController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tankerRoutes = routes.grouped("tanker")
        tankerRoutes.get(use: setTankerStatusHandler)
        tankerRoutes.get(":mode", use: setTankerStatusHandler)
        
        let misterRoutes = routes.grouped("mister")
        misterRoutes.get(use: setMisterHandler)
        misterRoutes.get(":mode", use: setMisterHandler)
        
    }
    
    //MARK:Tanker
    func setTankerStatusHandler(_ req: Request) -> String {
        let mode = req.parameters.get("mode")
        if mode != nil {
            let state = TankerMode(rawValue: mode!) ?? Tanker.main?.tankerState
            Tanker.main?.tankerState = state ?? .off
        }
        
        switch Tanker.main?.tankerState {
        case .off:
            return "0"
        default:
            return "1"
        }
    }
    
    //MARK:Mister
    func setMisterHandler(_ req: Request) -> String {
        let mode = req.parameters.get("mode")
       
        if mode != nil {
            let state = TankerMode(rawValue: mode!) ?? Tanker.main?.misterState
            Tanker.main?.misterState = state ?? .off
        }
        
        switch Tanker.main?.misterState {
        case .off:
            return "0"
        default:
            return "1"
        }
    }
    
}
