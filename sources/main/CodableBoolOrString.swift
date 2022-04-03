import Foundation

/**
 Codable that represents an Bool or a String.

 CodableBoolOrString solves cases where a JSON int appears as an Bool or a String:
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
public enum CodableBoolOrString: Codable, Hashable, ExpressibleByBooleanLiteral, ExpressibleByStringLiteral
{
    case bool(Bool)
    case string(String)

    public var string: String {

        switch self {
        case .bool(let bool): return "\(bool)"
        case .string(let string): return string
        }
    }

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int: CodableBoolOrString = try? .bool(container.decode(Bool.self)) {
            self = int
        } else if let string: CodableBoolOrString = try? .string(container.decode(String.self)) {
            self = string
        } else {
            throw DecodingError.typeMismatch(
                CodableBoolOrString.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected a Bool or String"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let bool):
            try container.encode(bool)
        case .string(let string):
            try container.encode(string)
        }
    }

    // MARK: - ExpressibleByBooleanLiteral

    public init(booleanLiteral value: Bool) {
        self = .bool(value)
    }

    // MARK: - ExpressibleByStringLiteral

    public init(stringLiteral value: String) {
        self = .string(value)
    }
}
