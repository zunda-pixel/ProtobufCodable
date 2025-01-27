import Foundation

extension Array: EncodableContainer where Element: EncodableContainer {
	func encodeForUnkeyedContainer() throws -> Data {
		try encodedElements().mapAndJoin {
			$0.encodeForUnkeyedContainer()
		}
	}

	func encode(forKey key: Int) throws -> Data {
		try encodedElements().mapAndJoin {
			$0.encode(forKey: key)
		}
	}

	private func encodedElements() throws -> [Data] {
		try self.map { element in
			return try element.encode(forKey: 1)
		}
	}

	private func encode<T>(_ value: T) throws -> EncodableContainer where T: Encodable {
		if T.self is EncodablePrimitive.Type, let base = value as? EncodablePrimitive {
			return base
		}
		// All non-primitive types are of type `len`
		let encoder = EncodingNode(codingPath: [], userInfo: [:])
		try value.encode(to: encoder)
		return encoder
	}
}
