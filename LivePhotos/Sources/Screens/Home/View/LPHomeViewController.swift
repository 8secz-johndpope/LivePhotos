//
//  ViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import PromiseKit
import RxSwift

final class LPHomeViewController: LPBaseViewController, LPRootableViewController {
    typealias RootView = LPHomeRootView
    
    // MARK: - Properties
    
    private let _viewModel: LPHomeViewModelAble
    private let _disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    init(viewModel: LPHomeViewModelAble) {
        _viewModel = viewModel
        super.init(LPHomeViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        _viewModel.fetchPhotos()
    }
    
}

// MARK: - Setup methods

private extension LPHomeViewController {
    
    func setupUI() {
        rootView.set(viewModel: _viewModel)
        setupSubscriptionsToViewModel()
    }
    
    func setupSubscriptionsToViewModel() {
        _viewModel.errorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.handleError(errorMessage)
            })
            .disposed(by: _disposeBag)
        
        _viewModel.savedPhotoStatusMessage
            .subscribe(onNext: { [weak self] msg in
                self?.showAlert(title: "HOME_SCREEN_TITLE".localized, message: msg, comment: nil)
            })
            .disposed(by: _disposeBag)
    }
    
}
