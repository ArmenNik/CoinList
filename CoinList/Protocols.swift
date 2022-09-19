//
//  Protocols.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import Combine
import Foundation

protocol NetworkEngine {
    typealias Headers = [String: Any]

    func get<T>(type: T.Type,
                  url: URL,
                  headers: Headers
      ) -> AnyPublisher<T, Error> where T: Decodable
    
    func update<T>(type: T.Type, url: URL, headers: Headers) async -> Data?
}

protocol BaseViewModel {

}

protocol DecoderUpdatable {
    mutating func update(from decoder: Decoder) throws
}

public struct DecoderExtractor: Decodable {
    public let decoder: Decoder

    public init(from decoder: Decoder) throws {
        self.decoder = decoder
    }
}

public protocol DecodingFormat {
    func decoder(for data: Data) -> Decoder
}
//
extension JSONDecoder: DecodingFormat {
    public func decoder(for data: Data) -> Decoder {
        // Can try! here because DecoderExtractor's init(from: Decoder) never throws
        return try! decode(DecoderExtractor.self, from: data).decoder
    }
}

extension Double {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current // Change this to another locale if you want to force a specific locale, otherwise this is redundant as the current locale is the default already
        formatter.numberStyle = .currency
        if let amount = formatter.string(from: self as NSNumber) {
           return amount
        }
        return ""
    }
}

struct Empty: Decodable { }

extension UnkeyedDecodingContainer {
  public mutating func skip() throws {
    _ = try decode(Empty.self)
  }
}
