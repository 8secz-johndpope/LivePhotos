//
//  LPHomeViewModelAble.swift
//  LivePhotos
//
//  Created by Office Mac on 1/26/20.
//  Copyright © 2020 Vinso. All rights reserved.
//

import Photos
import RxSwift
import RxRelay

protocol LPHomeViewModelAble {
    var numberOfItems: Int     { get }
    var kPagePadding : CGFloat { get }
    
    var items: Observable<[PHLivePhoto]> { get }
    
    var isActivityIndicatorAnimation: Observable<Bool> { get }
    var isSaveButtonEnabled         : Observable<Bool> { get }
    
    var savedPhotoStatusMessage     : Observable<String> { get }
    var errorMessage                : Observable<LPErrorMessage> { get }
    
    func fetchPhotos()
    func saveLivePhoto(_ livePhoto: PHLivePhoto)
    
    func item(at indexPath: IndexPath) -> PHLivePhoto
}
