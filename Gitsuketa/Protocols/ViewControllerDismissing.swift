//
//  ViewControllerDismissing.swift
//  Gitsuketa
//
//  Created by Maddin on 10.09.17.
//  Copyright © 2017 Maddin. All rights reserved.
//

import UIKit

protocol ViewControllerDismissing {
    var willDismiss: ((_ vc: Self) -> Void)? { get set }
}
