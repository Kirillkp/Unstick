//
//  Router.swift
//  CoordinatorLib
//
//  Created by Кирилл Полосов on 17.09.2022.
//

import UIKit

open class Router: Routable {
    
    // MARK:- Private variables
    fileprivate weak var rootController: UINavigationController?
    
    fileprivate var completions: RouterCompletions
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    public var toPresent: UIViewController? {
        return rootController
    }
    
    public func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    public func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard let controller = module?.toPresent,
              !(controller is UINavigationController) else {
            assertionFailure("⚠️Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        rootController?.pushViewController(controller, animated: animated)
    }
    
    public func popModule()  {
        popModule(animated: true)
    }
    
    public func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    public func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    public func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
