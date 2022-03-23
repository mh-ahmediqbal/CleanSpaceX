//
//  RocketsRouter.swift
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

@objc protocol RocketsRoutingLogic
{
    func routeToRocketDetails(segue: UIStoryboardSegue?)
}

protocol RocketsDataPassing
{
    var dataStore: RocketsDataStore? { get }
}

class RocketsRouter: NSObject, RocketsRoutingLogic, RocketsDataPassing
{
    weak var viewController: RocketsViewController?
    var dataStore: RocketsDataStore?
    
    // MARK: Routing
    
    func routeToRocketDetails(segue: UIStoryboardSegue?)
    {
        let storyboard = UIStoryboard(storyboard: .Main)
        let destinationVC: RocketDetailViewController =  storyboard.instantiateViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToRocketDetail(source: dataStore!, destination: &destinationDS)
        self.navigateToRocketDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToRocketDetails(source: RocketsViewController, destination: RocketDetailViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToRocketDetail(source: RocketsDataStore, destination: inout RocketDetailDataStore)
    {
        destination.rocketDetail = source.rocketDetail
    }
}