//
//  AppRouter.swift
//  NearbyWeather
//
//  Created by Erik Maximilian Martens on 01.02.20.
//  Copyright © 2020 Erik Maximilian Martens. All rights reserved.
//

import UIKit

enum MainCoordinatorStep: StepProtocol {
  case initial
  case none
}

final class MainCoordinator: Coordinator {
  
  // MARK: - Required Properties
  
  private static var _rootViewController: UITabBarController = {
    let tabbar = UITabBarController()
    tabbar.tabBar.backgroundColor = .white
    tabbar.tabBar.barTintColor = .white
    tabbar.tabBar.tintColor = Constants.Theme.BrandColors.standardDay
    return tabbar
  }()
  
  private static var _stepper: MainStepper = {
    let initialStep = InitialStep(
      identifier: MainCoordinatorStep.identifier,
      step: MainCoordinatorStep.initial
    )
    return MainStepper(initialStep: initialStep, type: MainCoordinatorStep.self)
  }()
  
  // MARK: - Additional Properties
  
  weak var windowManager: WindowManager?
  
  // MARK: - Initialization
  
  init(parentCoordinator: Coordinator?, windowManager: WindowManager) {
    self.windowManager = windowManager
    
    super.init(
      rootViewController: Self._rootViewController,
      stepper: Self._stepper,
      parentCoordinator: parentCoordinator,
      type: MainCoordinatorStep.self
    )
  }
  
  // MARK: - Navigation
  
  @objc override func didReceiveStep(_ notification: Notification) {
    super.didReceiveStep(notification, type: MainCoordinatorStep.self)
  }
  
  override func executeRoutingStep(_ step: StepProtocol, passNextChildCoordinatorTo coordinatorReceiver: @escaping (NextCoordinator) -> Void) {
    guard let step = step as? MainCoordinatorStep else { return }
    switch step {
    case .initial:
      summonMainTabbarController(passNextChildCoordinatorTo: coordinatorReceiver)
    case .none:
      break
    }
  }
}

// MARK: - Navigation Helper Functions

private extension MainCoordinator {
  
  func summonMainTabbarController(passNextChildCoordinatorTo coordinatorReceiver: (NextCoordinator) -> Void) {
    let root = rootViewController as? UITabBarController
    
    let weatherList = WeatherListCoordinator(parentCoordinator: self)
    let weatherMap = WeatherMapCoordinator(parentCoordinator: self)
    let settings = SettingsCoordinator(parentCoordinator: self)

    root?.viewControllers = [weatherList.rootViewController, weatherMap.rootViewController, settings.rootViewController]
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = root
    window.makeKeyAndVisible()
    windowManager?.window = window
    
    coordinatorReceiver(
      .multiple([weatherList, weatherMap, settings])
    )
  }
}
