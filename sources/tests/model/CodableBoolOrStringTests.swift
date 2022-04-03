@testable import CodableHelpers
import XCTest

private struct Blog: Codable {
    let paywallAccess: CodableBoolOrString

    enum CodingKeys: String, CodingKey {
        case paywallAccess = "paywall_access"
    }
}
/**
 Checks that Blog.age can be encoded/decoded between JSON and String or Bool.
 ```
 [
     { "paywall_access": true },
     { "paywall_access": "disabled" }
 ]
 ```
 This JSON can be parsed as follows:
 ```
 struct Blog: Codable {
     let paywallAccess: CodableBoolOrString
 }

 let jsonData = JSON.data(using: .utf8)!
 let person = try! JSONDecoder().decode([Blog].self, from: jsonData)
 ```
 */
final class CodableBoolOrStringTests: XCTestCase
{
    private let paywallStringJSON = "{\"paywall_access\":\"disabled\"}"
    private let paywallBoolJSON = "{\"paywall_access\":true}"

    func testExpressibleByBooleanLiteral() {
        let instance: CodableBoolOrString = true
        guard case let CodableBoolOrString.bool(value) = instance else {
            XCTFail("Expected to create a .bool")
            return
        }
        XCTAssertTrue(value)
    }

    func testExpressibleByStringLiteral() {
        let instance: CodableBoolOrString = "disabled"
        guard case let CodableBoolOrString.string(value) = instance else {
            XCTFail("Expected to create a .string")
            return
        }
        XCTAssertEqual(value, "disabled")
    }

    /// Encode to `{ "paywall_access": true }`.
    func testEncodeBool() throws
    {
        let blog = Blog(paywallAccess: CodableBoolOrString.bool(true))
        let blogData: Data = try! JSONEncoder().encode(blog)
        let JSON = String(data: blogData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, paywallBoolJSON)
    }
    
    /// Encode to `{ "paywall_access": "disabled" }`.
    func testEncodeString() throws
    {
        let blog = Blog(paywallAccess: CodableBoolOrString.string("disabled"))
        let blogData: Data = try! JSONEncoder().encode(blog)
        let JSON = String(data: blogData, encoding: String.Encoding.utf8)!
        XCTAssertEqual(JSON, paywallStringJSON)
    }

    /// Decode from `{ "paywall_access": true }`.
    func testDecodeFromJsonBool() throws
    {
        let blogData = paywallBoolJSON.data(using: .utf8)!
        let blog = try! JSONDecoder().decode(Blog.self, from: blogData)
        XCTAssertEqual(blog.paywallAccess, CodableBoolOrString.bool(true))
    }

    /// Decode from `{ "paywall_access": "disable" }`.
    func testDecodeFromJsonString() throws
    {
        let blogData = paywallStringJSON.data(using: .utf8)!
        let blog = try! JSONDecoder().decode(Blog.self, from: blogData)
        XCTAssertEqual(blog.paywallAccess, CodableBoolOrString.string("disabled"))
    }
}
