import Foundation

/// Convenience method to encode as a String.
public extension Encodable {

    /**
     Encode this Encodable to a String.

     - Returns: this instance encoded as a string –or nil in the unlikely case that this Encodable
     fails to encode.
     */
    func encode() throws -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let json = try encoder.encode(self)
        return String(data: json, encoding: .utf8)
    }
}
