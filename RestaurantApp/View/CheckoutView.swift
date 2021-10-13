//
//  CheckoutView.swift
//  RestaurantApp
//
//  Created by Linus Wang on 4/30/21.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var usingYPCoin = false
    @State private var YPCoinID = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    
    let paymentTypes = ["Cash", "Card", "YPCoin"]
    let tipAmounts = [10,15,20,25,0]
    
    var totalPrice: String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    
    var body: some View {
        Form{
            Section{
                Picker("How would you like to pay?", selection:
                        $paymentType){
                    ForEach(paymentTypes, id: \.self){
                        Text($0)
                    }
                }
                
                Toggle("Using YPCoin", isOn: $usingYPCoin.animation())
                if usingYPCoin{
                    TextField("Enter your YPCoin ID", text: $YPCoinID)
                }
            }
            
            Section(header: Text("Would you like to add a tip?")){
                Picker("Percentage:", selection: $tipAmount){
                    ForEach(tipAmounts, id:\.self){
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("TOTAL: \(totalPrice)").font(.largeTitle)){
                Button("Confirm order"){
                    showingPaymentAlert.toggle()
                }
            }
            .navigationTitle("Payment")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showingPaymentAlert){
                Alert(title: Text("Order confirmed"), message: Text("Your total: \(totalPrice)"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Order())
    }
}
