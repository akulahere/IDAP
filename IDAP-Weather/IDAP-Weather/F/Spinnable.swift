//
//  Spinnable.swift
//  IDAP-Weather
//
//  Created by Dmytro Akulinin on 26.06.2023.
//

import UIKit

protocol Spinnable {

    associatedtype SpinnerType: Spinner

    func showSpinner()
    func showSpinner(configure: F.Completion<SpinnerType.SpinnerView>?)

    func hideSpinner()
    func hideSpinner(configure: F.Completion<SpinnerType.SpinnerView>?)
}

extension Spinnable where Self: UIView {

    func showSpinner() {
        self.showSpinner(configure: nil)
    }

    func hideSpinner() {
        self.hideSpinner(configure: nil)
    }

    func showSpinner(configure: F.Completion<SpinnerType.SpinnerView>?) {
        SpinnerService.show(on: self, provider: SpinnerType.self, configure: configure)
    }

    func hideSpinner(configure: F.Completion<SpinnerType.SpinnerView>?) {
        SpinnerService.hide(from: self, provider: SpinnerType.self, configure: configure)
    }
}

