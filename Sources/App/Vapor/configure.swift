import Leaf
import Vapor


// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
  
//    app.views.use(.leaf)
    
    app.http.server.configuration.port = 8080
    app.http.server.configuration.hostname = "0.0.0.0"
    // register routes
    try routes(app)
}
