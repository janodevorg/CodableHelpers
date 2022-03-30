@testable import CodableHelpers
import XCTest

private struct Person: Codable {
    let age: CodableIntOrString
}
/**
 Checks that Person.age can be encoded/decoded between JSON and String or Int.
 ```
 { "age": 43 }
 { "age": "43" }
 ```
 */
final class CodableIntOrStringTests: XCTestCase
{
    private let ageStringJSON = "{\"age\":\"43\"}"
    private let ageIntJSON = "{\"age\":43}"

    /// Encode to `{ "age": 43 }`.
    func testEncodeInt() throws
    {
        let person = Person(age: CodableIntOrString.int(43))
        let personData: Data = try! JSONEncoder().encode(person)
        let JSON = String(data: personData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, ageIntJSON)
    }
    
    /// Encode to `{ "age": "43" }`.
    func testEncodeString() throws
    {
        let person = Person(age: CodableIntOrString.string("43"))
        let personData: Data = try! JSONEncoder().encode(person)
        let JSON = String(data: personData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, ageStringJSON)
    }

    /// Decode from `{ "value": 43 }`.
    func testDecodeFromJsonInt() throws
    {
        let personData = ageIntJSON.data(using: .utf8)!
        let person = try! JSONDecoder().decode(Person.self, from: personData)
        XCTAssertEqual(person.age, CodableIntOrString.int(43))
    }

    /// Decode from `{ "value": "43" }`.
    func testDecodeFromJsonString() throws
    {
        let personData = ageStringJSON.data(using: .utf8)!
        let person = try! JSONDecoder().decode(Person.self, from: personData)
        XCTAssertEqual(person.age, CodableIntOrString.string("43"))
    }
}
