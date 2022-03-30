import CodableHelpers
import XCTest

final class Encodable_encodeTests: XCTestCase {

    private struct Person: Codable, Equatable {
        let name: String
    }

    private let json = """
        { "name": "Alice" }
    """

    func testEncode() throws {
        let person = Person(name: "Alice")
        guard let encodedPerson: String = try person.encode() else {
            XCTFail("Failed to encode.")
            return
        }
        let decodedPerson: Person? = try Person.decode(json: encodedPerson)
        XCTAssertEqual(person, decodedPerson)
    }
}
