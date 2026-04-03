//
//  MainViewController.swift
//  Unstick
//
//  Created by Полосов Кирилл Павлович on 26.03.2026
//  
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    // MARK: Layout
    
    private enum Layout {
        static let indicatorSize: CGSize = CGSize(width: 256, height: 256)
    }
    
    // MARK: - Public Properties

    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties

    // MARK: - UI

    private let backgroundView = MeshGradientView()
    private let indicatorView = IndicatorView()

    // MARK: - Override

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createUI()
        presenter?.viewLoaded()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter?.viewWillDisappear(animated)
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {}

// MARK: - Create UI

private extension MainViewController {
    func createUI() {
        setupBackgroundView()
        setupIndicatorView()
    }
    
    func setupBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupIndicatorView() {
        view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(Layout.indicatorSize)
        }
        indicatorView.setState(.empty(IndicatorView.EmptyContent()))
    }
}
