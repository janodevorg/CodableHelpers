@testable import CodableHelpers
import XCTest

private struct SomeValue<T: Codable & Hashable>: Codable {
    let value: CodableArrayOrObject<T>
}

/**
 Checks that SomeValue<String> can be encoded/decoded between JSON and String or [String]:
 ```
 { "value": "deadbeef" }
 { "value": ["deadbeef", "cafebabe"] }
 ```
 */
final class CodableArrayOrObjectTests: XCTestCase
{
    private let objectJSON = "{\"value\":\"deadbeef\"}"
    private let arrayJSON = "{\"value\":[\"deadbeef\",\"cafebabe\"]}"

    /// Encode to `{ "value": "deadbeef" }`.
    func testEncodeString() throws
    {
        let someValue = SomeValue<String>(value: .object("deadbeef"))
        let jsonData: Data = try! JSONEncoder().encode(someValue)
        let JSON = String(data: jsonData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, objectJSON)
    }

    /// Encode to `{ "value": ["deadbeef", "cafebabe"] }`.
    func testEncodeArray() throws
    {
        let array = ["deadbeef", "cafebabe"]
        let someValue = SomeValue<String>(value: .array(array))
        let jsonData: Data = try! JSONEncoder().encode(someValue)
        let JSON = String(data: jsonData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, arrayJSON)
    }

    /// Decode from `{ "value": "deadbeef" }`.
    func testDecodeFromJsonObject() throws
    {
        let jsonData = objectJSON.data(using: .utf8)!
        let someValue = try! JSONDecoder().decode(SomeValue<String>.self, from: jsonData)
        XCTAssertEqual(someValue.value, CodableArrayOrObject<String>.object("deadbeef"))
    }

    /// Decode from `{ "value": ["deadbeef", "cafebabe"] }`.
    func testDecodeFromJsonArray() throws
    {
        let jsonData = arrayJSON.data(using: .utf8)!
        let someValue = try! JSONDecoder().decode(SomeValue<String>.self, from: jsonData)
        XCTAssertEqual(someValue.value, CodableArrayOrObject<String>.array(["deadbeef", "cafebabe"]))
    }
}
