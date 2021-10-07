import Foundation

/**
 A type that can provide its components as  encoded binary data.
 */
protocol EncodedDataProvider {

    func encodedData() throws -> Data

    func encodedDataWithKeys(_ key: CodingKey) throws -> Data
}

extension EncodedDataProvider {

    func encodedDataWithKeys(_ key: CodingKey) throws -> Data {
        try encodedData()
    }
}

extension Data: EncodedDataProvider {

    func encodedData() -> Data {
        self
    }
}
