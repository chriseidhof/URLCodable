import XCTest
import URLEncoder

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
    case test(Int?)
    case test2(Bool, Int?)
    case id(UUID)
    // todo
//    case test2(String?) // todo what do we do here with nil vs. empty string?
//    case defaultValue(Int = 5)
    // TODO mirror tests in decoding (nil, UUID, escaping)
    // todo multiple (optional) values
    // default values, nil, combining nil and other parameters
}

func testRoundtrip(_ lhs: Route?, _ rhs: String, file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(try encode(lhs), rhs, file: file, line: line)
    XCTAssertEqual(lhs, try decode(encode(lhs)), file: file, line: line)
}

final class RoundtripTests: XCTestCase {
    func testExample() throws {
        testRoundtrip(Route.index, "/index")
        testRoundtrip(Route.bar, "/bar")
        testRoundtrip(Route.foo(5), "/foo/5")
        testRoundtrip(Route.nested(.index), "/nested/index")
        testRoundtrip(Route.label(foo: "hello"), "/label/hello")
        testRoundtrip(Route.label(foo: "hello/world"), "/label/hello%2Fworld")
        testRoundtrip(Route.two(42, 50), "/two/42/50")
        testRoundtrip(Route.test(nil), "/test")
        testRoundtrip(Route.test(1), "/test/1")
        testRoundtrip(Route.test2(true, 1), "/test2/true/1")
        testRoundtrip(Route.test2(false, nil), "/test2/false")
        let id = UUID()
        testRoundtrip(Route.id(id), "/id/\(id.uuidString)")
        
    }
}
