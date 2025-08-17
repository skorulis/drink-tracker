import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "This is the drink tracker API"
    }

    app.get("v1/auth") { req async -> String in
        "Auth will go here"
    }

    try app.register(collection: TodoController())
}
