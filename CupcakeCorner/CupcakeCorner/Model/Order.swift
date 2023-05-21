//
//  Order.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 19/05/23.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    //Codable manual implementation
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAdress, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        //resetting extraFrosting and addSprinkles when you disable special request after setting it on
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAdress = ""
    @Published var city = ""
    @Published var zip = ""
    
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
    
    init (){ }
    
    //Codable manual implementation, econde process here
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAdress, forKey: .streetAdress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
    }
    
    //Codable manual implementation, decode process here
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAdress = try container.decode(String.self, forKey: .streetAdress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
        
    }
    
}
