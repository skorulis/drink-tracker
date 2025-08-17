import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "This is the drink tracker API"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())
}
