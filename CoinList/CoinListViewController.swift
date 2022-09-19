//
//  CoinListViewController.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit
import Combine

class CoinListViewController: UIViewController {

    var viewModel: CoinListViewModel?
    var subscribers = Set<AnyCancellable>()
    var cancellable: AnyCancellable?

    @IBOutlet weak var tableView: UITableView!
    var dataSource = CoinListResponse(coins: [CoinListResponse.Coin]())
    var timer = Timer()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let viewModel = viewModel {
            viewModel.fetchCoins()
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Success")
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: {[weak self] data in
                    self?.dataSource = data
                    self?.tableView.reloadData()
                    self?.scheduledTimerWithTimeInterval()
                }
                .store(in: &subscribers)
        }
    }

    private func scheduledTimerWithTimeInterval() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
            Task {
                let result = await self.viewModel?.updateCoins()
                if let res = result {
                    let decoder = JSONDecoder().decoder(for: res)
                    try? self.dataSource.update(from: decoder)
                    self.tableView.reloadData()
                }
            }
        })
    }
}

extension CoinListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.coins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CoinTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CoinTableViewCell", for: indexPath) as! CoinTableViewCell
        cell.populate(coin: self.dataSource.coins[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}
