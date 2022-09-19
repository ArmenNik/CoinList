//
//  CoinListViewModel.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit
import Combine

class CoinListViewModel: BaseViewModel {
    private var networkManager: NetworkEngine


    init(networkManager: NetworkEngine) {
        self.networkManager = networkManager
    }

    func fetchCoins() -> AnyPublisher<CoinListResponse, Error> {
        return self.networkManager.get(type: CoinListResponse.self, url: URL(string: "https://api.coin-stats.com/v3/coins")!, headers: [:])
    }

    func updateCoins() async -> Data? {
        return await self.networkManager.update(type: CoinListResponse.self, url: URL(string: "https://api.coin-stats.com/v3/coins?responseType=array")!, headers: [:])
    }

}
