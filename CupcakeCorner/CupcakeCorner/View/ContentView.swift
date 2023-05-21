//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 19/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var order = SharedOrder()
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(SharedOrder.types.indices){
                            Text(SharedOrder.types[$0])
                        }
                    }
                    
                    Stepper("Numbers of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
                
                
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
