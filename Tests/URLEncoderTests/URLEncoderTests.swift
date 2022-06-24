import XCTest
@testable import URLEncoder

enum Nested: Codable, Hashable {
    case index
}
enum Route: Codable, Hashable {
    case index
    case bar
    case foo(Int)
    case label(foo: String)
    case two(Int, Int)
    case nested(Nested)
}

final class URLEncoderTests: XCTestCase {
    func testExample() throws {
        
        XCTAssertEqual(try encode(Route.index), "/index")
        XCTAssertEqual(try encode(Route.bar), "/bar")
        XCTAssertEqual(try encode(Route.foo(5)), "/foo/5")
        XCTAssertEqual(try encode(Route.nested(.index)), "/nested/index")
        XCTAssertEqual(try encode(Route.label(foo: "hello")), "/label/hello")
        XCTAssertEqual(try encode(Route.two(42, 50)), "/two/42/50")
    }
}
