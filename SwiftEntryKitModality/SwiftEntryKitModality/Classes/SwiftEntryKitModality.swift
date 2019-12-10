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
    
    open func commonInit() { }
    
    // MARK: - ModalityContentProtocol
    
    open func willLoadModality(attributes: inout EKAttributes) { }
    
    open func willShow() { }
    
    public var _attributes: EKAttributes {
        get {
            return modalityAttributes
        }
        set {
            modalityAttributes = newValue
        }
    }
    
    open var canShow: Bool {
        return true
    }
    
}

// MARK: - ModalityLifecycleEventProtocol

public protocol ModalityLifecycleEventProtocol  {
    
    typealias LifecycleHandlerEvent = SwiftEntryKit.DismissCompletionHandler
    
    var willAppear      : LifecycleHandlerEvent? { get }
    
    var didAppear       : LifecycleHandlerEvent? { get }
    
    var willDisappear   : LifecycleHandlerEvent? { get }
    
    var didDisappear    : LifecycleHandlerEvent? { get }
    
}

// MARK: - ModalityProtocol

public protocol ModalityProtocol: class {
    
    func show(presentInsideKeyWindow: Bool, rollbackWindow: SwiftEntryKit.RollbackWindow)
    
    func dismiss()
    
}

public extension ModalityProtocol where Self: ModalityContentProtocol {
    
    func show(presentInsideKeyWindow: Bool = false,
              rollbackWindow: SwiftEntryKit.RollbackWindow = .main) {
        self.willLoadModality(attributes: &_attributes)
        self.prepareModal()
        
        if canShow {
            self.willShow()
            SwiftEntryKit.display(entry: self.modalView,
                                  using: self.attributes,
                                  presentInsideKeyWindow: presentInsideKeyWindow,
                                  rollbackWindow: rollbackWindow)
        }
    }
    
    func dismiss() {
        SwiftEntryKit.dismiss(.specific(entryName: self.identifier))
    }
    
}

// MARK: - ModalityContentProtocol

public protocol ModalityContentProtocol: class {
    
    // MARK: - Private
    
    var _attributes: EKAttributes { set get }
    
    // MARK: - Public
    
    var canShow: Bool { get }
    
    var identifier: String { get }
    
    var modalView: UIView { get }
    
    var attributes: EKAttributes { get }
    
    func willLoadModality(attributes: inout EKAttributes)
    
    func willShow()
    
}

extension ModalityContentProtocol where Self: UIView {
    
    public var attributes: EKAttributes {
        return _attributes
    }
    
    public var modalView: UIView {
        return self
    }
    
    public var identifier: String {
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
