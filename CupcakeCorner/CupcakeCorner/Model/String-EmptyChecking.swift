//
//  String-EmptyChecking.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 21/05/23.
//

import Foundation

extension String {
    var isReallyEmpty: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
