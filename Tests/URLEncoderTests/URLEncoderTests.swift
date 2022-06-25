import XCTest
@testable import URLEncoder

final class URLEncoderTests: XCTestCase {
    func testExample() throws {
        
        XCTAssertEqual(try encode(Route.index), "/index")
        XCTAssertEqual(try encode(Route.bar), "/bar")
        XCTAssertEqual(try encode(Route.foo(5)), "/foo/5")
        XCTAssertEqual(try encode(Route.nested(.index)), "/nested/index")
        XCTAssertEqual(try encode(Route.label(foo: "hello")), "/label/hello")
        XCTAssertEqual(try encode(Route.label(foo: "hello/world")), "/label/hello%2Fworld")
        XCTAssertEqual(try encode(Route.two(42, 50)), "/two/42/50")
        XCTAssertEqual(try encode(Route.test(nil)), "/test")
        XCTAssertEqual(try encode(Route.test(1)), "/test/1")
        let id = UUID()
        XCTAssertEqual(try encode(Route.id(id)), "/id/\(id.uuidString)")
        
    }
}
