//
//  Order.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 19/05/23.
//

import SwiftUI

@dynamicMemberLookup
class SharedOrder: ObservableObject{

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var data = Order()
    
    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T {
        data[keyPath: keyPath]
    }
    
    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
        get {
            data[keyPath: keyPath]
        }
        set {
            data[keyPath: keyPath] = newValue
        }
    }
}


struct Order: Codable {
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        //resetting extraFrosting and addSprinkles when you disable special request after setting it on
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAdress = ""
    var city = ""
    var zip = ""
    
    //Ckecking if address is empty
    var isValidAddress: Bool {
        if name.isReallyEmpty || streetAdress.isReallyEmpty || city.isReallyEmpty || zip.isReallyEmpty {
            return false
        }
        return true
    }
    
    //Claculating the cost
    var cost: Double {
        //2 dollar per cake
        var cost = Double(quantity) * 2
        
        //complicated cake cost more
        cost += Double((type) / 2)
        
        //Extra 1$ for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //0.50 per cake for spinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }

}
