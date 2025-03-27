//
//  BaseViewModel.swift
//  Wala
//
//  Created by Ann on 05/02/2024.
//

import Combine

protocol ViewModel {
    var cancellables: Set<AnyCancellable> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorPublisher: PassthroughSubject<String?, Never> { get }
    var errorUnAuthorizedPublisher: PassthroughSubject<String?, Never> { get }
    var errorNotFoundPublisher: PassthroughSubject<String?, Never> { get }
}

class BaseViewModel {
    var cancellables: Set<AnyCancellable> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorPublisher: PassthroughSubject<String, Never> = .init()
    var errorUnAuthorizedPublisher: PassthroughSubject<String?, Never> = .init()
    var errorNotFoundPublisher: PassthroughSubject<String?, Never> = .init()
}
