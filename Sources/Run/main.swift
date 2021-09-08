import Foundation
import App

public let vaporController: VaporController = VaporController()
public var tankerController: TankerController = TankerController()

//Start the Tank Controller
tankerController.start()
//Start the Vapor Controller
vaporController.startVapor()

//MARK:CLI
//TODO!!!
//var shouldExit = false
//var i = 0
//while(!shouldExit){
//    
//    print("Mister Mode: ", terminator:" ")
//    let input = readLine(strippingNewline: true)
//    let misterMode: TankerState = TankerState(rawValue: input!) ?? .off
//    shouldExit = (input=="x") ? true : false
//     
//    if !shouldExit {
//        tank.misterState = misterMode
//    }
//}
//


// Signal interrupt handler
signal(SIGINT) { signal in
    print("End of Line:\(signal)")
   exit(signal)
}

