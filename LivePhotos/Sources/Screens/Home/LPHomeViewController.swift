//
//  ViewController.swift
//  LivePhotos
//
//  Created by Office Mac on 1/12/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import PromiseKit

final class LPHomeViewController: LPBaseViewController, LPRootableViewController {
    typealias RootView = LPHomeRootView
    
    private let _photosService: LPLivePhotosService

    private var images: [LPLivePhoto] = []
    private var imageIndex = 0
    
    // MARK: - Lifecycle

    init(photosService: LPLivePhotosService) {
        _photosService = photosService
        
        super.init(LPHomeViewController.self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        fetchPhotos()
    }
    
}

// MARK: - Setup methods

private extension LPHomeViewController {
    
    func setupUI() {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController!.navigationBar.isHidden = true
    }
    
}

// MARK: - User interactions

private extension LPHomeViewController {
    
    @IBAction func actSwipeLeft(_ sender: Any) {
        print(#function)
    }
    
    @IBAction func actSwipeRight(_ sender: Any) {
        print(#function)
    }
    
}

// MARK: - API

private extension LPHomeViewController {
    
    func fetchPhotos() {
        rootView.activityIndicator.startAnimating()
        _photosService.fetchPhotos()
            .done { [weak self] photos in
                guard let self = self else { return }
                self.images = photos
                self.rootView.setImages(photos)
            }
            .catch { [weak self] err in
                guard let self = self else { return }
                let errMsg = LPErrorMessage(title: "LOADING_PHOTOS".localized, message: err.localizedDescription)
                self.handleError(errMsg)
            }.finally { [weak self] in
                self?.rootView.activityIndicator.stopAnimating()
            }
    }
    
}
