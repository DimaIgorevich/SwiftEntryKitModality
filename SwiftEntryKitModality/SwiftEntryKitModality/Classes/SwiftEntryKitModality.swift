//
//  SwiftEntryKitModality.swift
//  PLCFarm
//
//  Created by dima on 9/30/19.
//  Copyright © 2019 PLC Group AG. All rights reserved.
//

import UIKit
import SwiftEntryKit

// MARK: - SwiftEntryKitModality

open class SwiftEntryKitModalityView: UIView, ModalityContentProtocol {
    
    // MARK: - Properties
    
    fileprivate var modalityAttributes = EKAttributes()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    public func commonInit() { }
    
    // MARK: - ModalityContentProtocol
    
    public func willLoadModality(attributes: inout EKAttributes) { }
    
    var _attributes: EKAttributes {
        get {
            return modalityAttributes
        }
        set {
            modalityAttributes = newValue
        }
    }
    
}

// MARK: - ModalityLifecycleEventProtocol

protocol ModalityLifecycleEventProtocol  {
    
    typealias LifecycleHandlerEvent = SwiftEntryKit.DismissCompletionHandler
    
    var willAppear      : LifecycleHandlerEvent? { get }
    
    var didAppear       : LifecycleHandlerEvent? { get }
    
    var willDisappear   : LifecycleHandlerEvent? { get }
    
    var didDisappear    : LifecycleHandlerEvent? { get }
    
}

// MARK: - ModalityProtocol

protocol ModalityProtocol: class {
    
    func show(presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow)
    
    func dismiss()
    
}

extension ModalityProtocol where Self: ModalityContentProtocol {
    
    func show(presentInsideKeyWindow: Bool = false,
              rollbackWindow: SwiftEntryKit.RollbackWindow = .main) {
        self.willLoadModality(attributes: &_attributes)
        self.prepareModal()
        
        SwiftEntryKit.display(entry: self.modalView,
                              using: self.attributes,
                              presentInsideKeyWindow: presentInsideKeyWindow,
                              rollbackWindow: rollbackWindow)
    }
    
    func dismiss() {
        SwiftEntryKit.dismiss(.specific(entryName: self.identifier))
    }
    
}

// MARK: - ModalityContentProtocol

protocol ModalityContentProtocol: class {
    
    // MARK: - Private
    
    var _attributes: EKAttributes { set get }
    
    // MARK: - Public
    
    var identifier: String { get }
    
    var modalView: UIView { get }
    
    var attributes: EKAttributes { get }
    
    func willLoadModality(attributes: inout EKAttributes)
    
}

extension ModalityContentProtocol where Self: UIView {
    
    var attributes: EKAttributes {
        return _attributes
    }
    
    var modalView: UIView {
        return self
    }
    
    var identifier: String {
        return self.className
    }
    
}

extension ModalityContentProtocol {
    
    fileprivate func prepareModal() {
        _attributes.name = self.identifier
        if let handler = self as? (ModalityLifecycleEventProtocol & ModalityContentProtocol) {
            handler.observeLifecycle()
        }
    }
    
}

extension ModalityContentProtocol where Self: ModalityLifecycleEventProtocol {
    
    func observeLifecycle() {
        _attributes.lifecycleEvents.willAppear      = self.willAppear
        _attributes.lifecycleEvents.didAppear       = self.didAppear
        _attributes.lifecycleEvents.willDisappear   = self.willDisappear
        _attributes.lifecycleEvents.didDisappear    = self.didDisappear
    }
    
}
