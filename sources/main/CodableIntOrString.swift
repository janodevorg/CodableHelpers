import Foundation

/**
 Codable that represents an Int or a String.

 CodableIntOrString solves cases where a JSON int appears as an Int or a String:
 ```
 [
     { "age": 43 },
     { "age": "43" }
 ]
 ```

 This JSON can be parsed as follows:
 ```
 struct Person: Codable {
     let age: CodableIntOrString
 }

 let jsonData = JSON.data(using: .utf8)!
 let person = try! JSONDecoder().decode([Person].self, from: jsonData)
 ```
 */
public enum CodableIntOrString: Codable, Hashable
{
    case int(Int)
    case string(String)

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let int: CodableIntOrString = try? .int(container.decode(Int.self)) {
            self = int
        } else if let string: CodableIntOrString = try? .string(container.decode(String.self)) {
            self = string
        } else {
            throw DecodingError.typeMismatch(
                CodableIntOrString.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected a Int or String"
                )
            )
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let int):
            try container.encode(int)
        case .string(let string):
            try container.encode(string)
        }
    }
}
