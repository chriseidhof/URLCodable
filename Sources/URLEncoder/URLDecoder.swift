//
//  File.swift
//  
//
//  Created by Chris Eidhof on 24.06.22.
//

import Foundation

public func decode<D: Decodable>(_ value: String) throws -> D {
    let parts = value.split(separator: "/")
    let decoder = URLDecoder(remainder: parts.map { String($0) })
    return try D(from: decoder)
}

fileprivate final class URLDecoder: Decoder {
    var codingPath: [CodingKey] = []
    let userInfo: [CodingUserInfoKey : Any] = [:]
    var remainder: [String]
    init(remainder: [String]) {
        self.remainder = remainder
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        var kdc = KDC<Key>(root: self)
        kdc.codingPath = codingPath
        return .init(kdc)
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        fatalError("TODO")
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        SVC(root: self)
    }
    
    fileprivate func decodeNil() -> Bool {
        return remainder.isEmpty
    }
    
    func removeFirst<A>(_ transform: (String) -> A?) throws -> A {
        guard let f = remainder.first, let t = transform(f) else {
            throw MyError()
        }
        remainder.removeFirst()
        return t
    }
    
    func decodeBool() throws -> Bool {
        try removeFirst { $0 == "true" ? true : ($0 == "false" ? false : nil )}
    }
    
    func decodeInt() throws -> Int {
        try removeFirst { Int($0) }
    }

    func decodeString() throws -> String {
        try removeFirst { $0.removingPercentEncoding }
    }
}

struct MyError: Error { } // todo

fileprivate struct SVC: SingleValueDecodingContainer {
    var codingPath: [CodingKey] = []
    unowned var root: URLDecoder
    
    var remainder: [String] {
        get { root.remainder }
        nonmutating set { root.remainder = newValue }
    }
    
    func decodeNil() -> Bool {
        return root.decodeNil()
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        try root.decodeBool()
    }
    
    func decode(_ type: String.Type) throws -> String {
        try root.decodeString()
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        fatalError("TODO")
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        fatalError("TODO")
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        try root.decodeInt()
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        fatalError("TODO")
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        fatalError("TODO")
    }
    
    
}

fileprivate struct KDC<Key: CodingKey>: KeyedDecodingContainerProtocol {
    var codingPath: [CodingKey] = []
    var allKeys: [Key] = []
    unowned var root: URLDecoder
    
    init(root: URLDecoder) {
        self.root = root
        if let f = remainder.first, let key = Key(stringValue: f) {
            remainder.removeFirst()
            allKeys = [key]
        }
    }
    
    
    var remainder: [String] {
        get { root.remainder }
        nonmutating set { root.remainder = newValue }
    }
    
    func contains(_ key: Key) -> Bool {
        if key.stringValue.hasPrefix("_") {
            let remainder = key.stringValue.dropFirst()
            if Int(remainder) != nil { return true }
        }
        return allKeys.contains(where: { $0.stringValue == key.stringValue })
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        root.decodeNil()
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        try root.decodeBool()
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        try root.decodeString()
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        fatalError("TODO")
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        fatalError("TODO")
    }
    
    mutating func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        try root.decodeInt()
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        fatalError("TODO")
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        fatalError("TODO")
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        fatalError("TODO")
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T : Decodable {
        try T(from: root)
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
        let kdc = KDC<NestedKey>(root: root)
        return .init(kdc)
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        fatalError("TODO")
    }
    
    func superDecoder() throws -> Decoder {
        fatalError("TODO")
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        fatalError("TODO")
    }
    
    
}
