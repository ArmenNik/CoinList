//
//  CoinData.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit

struct CoinListResponse: Codable, DecoderUpdatable {

    var coins: [Coin]

    enum CodingKeys: String, CodingKey {
        case coins = "coins"
    }

    mutating func update(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var dataContainer = try container.nestedUnkeyedContainer(forKey: .coins)
        while !dataContainer.isAtEnd {
            let nestedDecoder = try dataContainer.superDecoder()
            try self.coins[dataContainer.currentIndex - 1].update(from: nestedDecoder)
        }
    }

    public struct Coin: Codable, DecoderUpdatable {
        var i: String?
        var r: Int?
        var pu: Double? // price usd
        var pb: Double?
        var v: Double?
        var n: String?
        var s: String?
        var ic: String?
        var m: Int?
        var p1: Double?
        var p24: Double?
        var p7: Double?
        var a: Double?
        var t: Double?
        var tu: String?
        var csd: Bool?

        enum CKeys: String, CodingKey {
            case i = "i"
            case r = "r"
            case pu = "pu"
            case pb = "pb"
            case n = "v"
            case s = "s"
            case ic = "ic"
            case m = "m"
            case p1 = "p1"
            case p24 = "p24"
            case p7 = "p7"
            case a = "a"
            case t = "t"
            case tu = "tu"
            case csd = "csd"
        }

        mutating func update(from decoder: Decoder) throws {
            var values = try decoder.unkeyedContainer()
            try? values.skip()
            try? values.skip()
            self.pu = try? values.decode(Double.self)
        }
    }

}
