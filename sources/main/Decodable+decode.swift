import Foundation

/// Convenience methods to decode Strings and Data to an instance of this Decodable.
public extension Decodable
{
    /// Decodes an instance of this Decodable from an optional JSON string.
    static func decode(json: String?) throws -> Self? {
        guard let json = json else {
            return nil
        }
        return try decode(json: json)
    }

    /// Decodes an instance of this Decodable from a JSON string.
    static func decode(json: String) throws -> Self? {
        guard let json = json.data(using: .utf8) else {
            return nil
        }
        return try decode(json: json)
    }

    /// Decodes an instance of this Decodable from an optional Data instance.
    static func decode(json: Data?) throws -> Self? {
        guard let json = json else {
            return nil
        }
        return try JSONDecoder().decode(Self.self, from: json)
    }

    /// Decodes an instance of this Decodable from a Data instance.
    static func decode(json: Data) throws -> Self? {
        return try JSONDecoder().decode(Self.self, from: json)
    }
}
