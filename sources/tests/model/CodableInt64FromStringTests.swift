@testable import CodableHelpers
import XCTest

private struct Person: Codable {
    let age: CodableInt64FromString
}

/**
 Checks that Person.age can be encoded/decoded between JSON string and Int64.
 ```
 { "age": "43" }
 ```
 */
final class CodableInt64FromStringTests: XCTestCase
{
    private let JSON = "{\"age\":\"43\"}"

    /// Encode to `{ "value": "43" }`.
    func testEncodeString() throws
    {
        let person = Person(age: CodableInt64FromString(43))
        let personData: Data = try! JSONEncoder().encode(person)
        let personString = String(data: personData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, personString)
    }

    /// Decode from `"{\"age\":"43"}"`.
    func testDecodeFromJsonObject() throws
    {
        let personData = JSON.data(using: .utf8)!
        let person = try! JSONDecoder().decode(Person.self, from: personData)
        XCTAssertEqual(person.age, CodableInt64FromString(43))
    }
}
