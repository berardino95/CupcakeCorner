//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Berardino Chiarello on 20/05/23.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: SharedOrder
    
    @State private var alertTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order"){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingConfirmation) {
            Button ("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        //Try encode the data
        guard let encoded = try? JSONEncoder().encode(order.data) else {
            print("Failed to encode order")
            return
        }
        
        //reqres.in is a server for test data sending or retriving
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        //creating and configuring the request
        var request = URLRequest(url: url)
        //Setting the Type
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //Setting the HTTP Method
        request.httpMethod = "POST"
        
        do {
            //Making network request taking only data ignoring all other property
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            //Decode the responde from the server
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            //Filling alert message with decoded data
            alertTitle = "Thank You"
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(SharedOrder.types[decodedOrder.type]) cupcakes is on its way!"
            showingConfirmation = true
            
        } catch {
            //comment request.httpMethod to test error alert
            alertTitle = "Error"
            confirmationMessage = "Sorry, checkout failed. \n\nMessage: \(error.localizedDescription)"
            showingConfirmation = true
            print("Checkout error")
        }
 
    }
    
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: SharedOrder())
        }
    }
}
