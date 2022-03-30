import Foundation

/**
 Codable that represents a type or an array of types.
 The specific type is provided as a generic parameter.

 For instance, CodableArrayOrObject<String> solves cases where a value may be String or [String].
 ```
 [
     { "employees": "Alice" },
     { "employees": ["Alice", "Bob"] }
 ]
 ```

 This JSON can be parsed as follows:
 ```
 struct Company: Codable {
     let employees: CodableArrayOrObject<String>
 }

 let jsonData = JSON.data(using: .utf8)!
 let company = try! JSONDecoder().decode([Company].self, from: jsonData)
 ```
 */
public enum CodableArrayOrObject<T: Codable & Hashable>: Codable, Hashable {

    case array([T])
    case object(T)

    public var arrayValue: [T]? {
        switch self {
        case .array(let array): return array
        default:
            let array: [T]? = nil
            return array
        }
    }

    public var objectValue: T? {
        switch self {
        case .object(let object): return object
        default:
            let object: T? = nil
            return object
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let array = try? container.decode([T].self) {
            self = .array(array)
        } else {
            self = .object(try container.decode(T.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .array(let array):
            try container.encode(array)
        case .object(let object):
            try container.encode(object)
        }
    }
}
