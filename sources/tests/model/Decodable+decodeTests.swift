import CodableHelpers
import XCTest

final class Decodable_decodeTests: XCTestCase {

    private struct Person: Codable, Equatable {
        let name: String
    }

    private let json = """
        { "name": "Alice" }
    """

    func testDecode() throws {
        let person = try Person.decode(json: json)
        XCTAssertEqual(person, Person(name: "Alice"))
    }
}
