//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 19/05/23.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: SharedOrder
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAdress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
                    .keyboardType(.numberPad)
            }
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.words)
            
            Section{
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.isValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem (placement: .keyboard){
                Button("Clear address") {
                    order.name = ""
                    order.streetAdress = ""
                    order.city = ""
                    order.zip = ""
                }
            }
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        //Putting the View in the NavigationView to see the Navigation Title Bar
        NavigationView {
            AddressView(order: SharedOrder())
        }
        
    }
}
