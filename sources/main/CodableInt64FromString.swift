import Foundation

/**
 Codable that is a Int64 encoded from/to a String.

 CodableInt64FromString solves cases where a JSON int appears as a string:
 ```
 { "id": "429346429438" }
 ```

 This JSON can be parsed as follows:
 ```
 struct Foo: Codable {
     let id: CodableInt64FromString
 }

 let jsonData = JSON.data(using: .utf8)!
 let foo = try! JSONDecoder().decode(Foo.self, from: jsonData)
 ```
 */
public struct CodableInt64FromString: Codable, ExpressibleByIntegerLiteral, Hashable, CustomStringConvertible
{
    public let value: Int64

    // MARK: - ExpressibleByIntegerLiteral

    public typealias IntegerLiteralType = Int64

    public init(integerLiteral value: Self.IntegerLiteralType) {
        self.value = value
    }

    // MARK: - Codable

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int64 = try? container.decode(Int64.self) {
            self.value = int64
            return
        } else if let string = try? container.decode(String.self), let int64 = Int64(string) {
            self.value = int64
            return
        }
        throw DecodingError.typeMismatch(
            CodableInt64FromString.self,
            DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Expected id value to contain a 64 bit integer."
            )
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value.description)
    }

    // MARK: - CustomStringConvertible

    public var description: String {
        "\(value)"
    }

    // MARK: - Equatable

    public static func == (lhs: CodableInt64FromString, rhs: Any) -> Bool {
        "\(lhs)" == "\(rhs)"
    }
    public static func == (lhs: Any, rhs: CodableInt64FromString) -> Bool {
        "\(lhs)" == "\(rhs)"
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(value.hashValue)
    }
}
