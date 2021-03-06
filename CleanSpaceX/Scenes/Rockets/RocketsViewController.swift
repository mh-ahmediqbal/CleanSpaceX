//
//  RocketsViewController.swift
//  CleanSpaceX
//
//  Created by Ahmed Iqbal on 8/18/21.
//  Copyright (c) 2021 ___SpaceX___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SwiftUI

protocol RocketsDisplayLogic: AnyObject
{
    func displayRockets(viewModel: Rockets.SpaceX.ViewModel)
    func displaySendRocketDetail(viewModel: Rockets.SendRocketDetail.ViewModel)
}

class RocketsViewController: UIViewController, RocketsDisplayLogic
{
    var interactor: RocketsBusinessLogic?
    var router: (NSObjectProtocol & RocketsRoutingLogic & RocketsDataPassing)?
    var dataSourceRockets: [Rocket]?
    @IBOutlet weak var tableView: UITableView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = RocketsInteractor()
        let presenter = RocketsPresenter()
        let router = RocketsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getRocketsData()
        self.tableView.register(UINib(nibName: "RocketsCell", bundle: nil), forCellReuseIdentifier: "RocketsCell")
    }
    
    func setupViews() {
        self.title = "CleanSpaceX"
    }
    // MARK: GET ROCKETS DATA
    
    func getRocketsData()
    {
        let request = Rockets.SpaceX.Request()
        interactor?.fetchRockets(request: request)
    }
    
    func displayRockets(viewModel: Rockets.SpaceX.ViewModel)
    {
        if (viewModel.rockets != nil) {
            dataSourceRockets = viewModel.rockets
            self.tableView.reloadData()
        }
    }
    
    func sendRocketDetail(rocket: Rocket)
    {
        let request = Rockets.SendRocketDetail.Request(rocket: rocket)
        interactor?.sendRocketsList(request: request)
    }
    
    func displaySendRocketDetail(viewModel: Rockets.SendRocketDetail.ViewModel)
    {
        router?.routeToRocketDetails(segue: nil)
    }
}

extension RocketsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceRockets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
          withIdentifier: "RocketsCell", for: indexPath
        ) as? RocketsCell ?? RocketsCell(style: .default, reuseIdentifier: "RocketsCell")

        if let rocket = dataSourceRockets?[indexPath.row] {
            print(rocket)
            cell.setupCell(rocket: rocket)
            cell.selectionStyle = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let rocketDetail = dataSourceRockets?[indexPath.row] {
            sendRocketDetail(rocket: rocketDetail)
        }
    }
}


extension RocketsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

}
