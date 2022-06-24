public func encode<E: Encodable>(_ value: E) throws -> String {
    let e = URLEncoder()
    try value.encode(to: e)
    return "/" + e.result.joined(separator: "/")
}

final class URLEncoder: Encoder {
    let codingPath: [CodingKey] = []
    let userInfo: [CodingUserInfoKey : Any] = [:]
    var result: [String] = []
    
    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        return KeyedEncodingContainer(KEC(root: self))
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        fatalError("TODO")
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        fatalError("TODO")
    }
    
    
}

struct KEC<Key: CodingKey>: KeyedEncodingContainerProtocol {
    var codingPath: [CodingKey] = []
    unowned var root: URLEncoder
    
    mutating func encodeNil(forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        root.result.append(value)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        root.result.append("\(value)")
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        fatalError("TODO")

    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        fatalError("TODO")
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        fatalError("TODO")

    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
//        root.result.append(key.stringValue)
        try value.encode(to: root)
//        print(root.result)
//        fatalError("TODO")
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        root.result.append(key.stringValue)
        return .init(KEC<NestedKey>(root: root))

    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        
        fatalError("TODO")

    }
    
    mutating func superEncoder() -> Encoder {
        fatalError("TODO")
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        fatalError("TODO")
    }
}
