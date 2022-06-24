import XCTest
import URLEncoder

final class URLDecoderTests: XCTestCase {
    func testExample() throws {
        
        XCTAssertEqual(try decode("/index"), Route.index)
        XCTAssertEqual(try decode("/bar"), Route.bar)
        XCTAssertEqual(try decode("/foo/5"), Route.foo(5))
        XCTAssertEqual(try decode("/nested/index"), Route.nested(.index))
        XCTAssertEqual(try decode("/label/hello"), Route.label(foo: "hello"))
        XCTAssertEqual(try decode("/two/42/50"), Route.two(42, 50))
    }
}
