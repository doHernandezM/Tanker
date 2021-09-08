import Vapor

// Right now we do not need any other routes for home page. Let's keep things vague for privacy's sake(No splash screens with version numbers.)
func routes(_ app: Application) throws {
    app.get { req in
        return req.redirect(to: "https://www.youtube.com/watch?v=RfiQYRn7fBg")
    }
    
    let routeController = RouteController()
    try app.register(collection: routeController)
    
}
