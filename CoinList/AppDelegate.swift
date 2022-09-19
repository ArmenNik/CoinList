//
//  AppDelegate.swift
//  CoinList
//
//  Created by Armen Nikoghosyan on 18/09/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let coinListViewController: CoinListViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CoinListViewController") as! CoinListViewController
        coinListViewController.viewModel = CoinListViewModel(networkManager: CoinListNetworkManager())
        window?.rootViewController = coinListViewController
        window?.makeKeyAndVisible()
        return true
    }
}

