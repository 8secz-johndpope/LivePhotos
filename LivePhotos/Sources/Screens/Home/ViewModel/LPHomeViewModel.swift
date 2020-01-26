//
//  LPPhotosScrollView.swift
//  LivePhotos
//
//  Created by Bogdan Sasko on 14.01.2020.
//  Copyright © 2020 Vinso. All rights reserved.
//

import UIKit
import Photos
import RxSwift
import RxRelay

protocol LPHomeViewModelAble {
    var numberOfItems: Int { get }
    var kPagePadding: CGFloat { get }
    
    var items: Observable<[PHLivePhoto]> { get }
    var isActivityIndicatorAnimation: Observable<Bool> { get }
    var errorMessage: Observable<LPErrorMessage> { get }
    
    func fetchPhotos()
    
    func item(at indexPath: IndexPath) -> PHLivePhoto
}

final class LPHomeViewModel: LPHomeViewModelAble {
    
    private let _photosRepository: LPPhotosRepository

    private let _items = BehaviorRelay<[PHLivePhoto]>(value: [])
    private let _isActivityIndicatorAnimation = BehaviorRelay(value: false)
    private let _errorMessage = PublishSubject<LPErrorMessage>()
    
    // MARK: - Lifecycle
    
    init(photosRepository: LPPhotosRepository) {
        _photosRepository = photosRepository
    }
    
    func item(at indexPath: IndexPath) -> PHLivePhoto {
        let item = _items.value[indexPath.row]
        return item
    }
    
}

// MARK: - Getters

extension LPHomeViewModel {
    
    var numberOfItems: Int {
        return _items.value.count
    }
    
    var kPagePadding: CGFloat {
        return 10
    }
    
}

// MARK: - Rx Getters

extension LPHomeViewModel {
    
    var isActivityIndicatorAnimation: Observable<Bool> {
        return _isActivityIndicatorAnimation.asObservable()
    }
    
    var items: Observable<[PHLivePhoto]> {
        return _items.asObservable()
    }
    
    var errorMessage: Observable<LPErrorMessage> {
        return _errorMessage.asObservable()
    }
    
}

// MARK: - API

extension LPHomeViewModel {
    
    func fetchPhotos() {
        _isActivityIndicatorAnimation.accept(true)
        
        _photosRepository.fetchLivePhotos()
            .done { [weak self] photos in
                guard let self = self else { return }
                self._items.accept(photos)
            }
            .catch { [weak self] err in
                guard let self = self else { return }
                
                let message: String?
                if let e = err as? LPLivePhotoError {
                    message = e.localizedDescription
                } else {
                    message = err.localizedDescription
                }
                
                let errMsg = LPErrorMessage(title: "LOADING_PHOTOS".localized, message: message)
                self._errorMessage.onNext(errMsg)
            }.finally { [weak self] in
                self?._isActivityIndicatorAnimation.accept(false)
            }
    }
    
}
