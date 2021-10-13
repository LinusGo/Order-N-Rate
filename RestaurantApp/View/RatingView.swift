//
//  RatingView.swift
//  RestaurantApp
//
//  Created by Linus Wang on 4/30/21.
//

import SwiftUI

struct RatingView: View {
    @StateObject var RatingModel = RatingViewModel()
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                
                HStack(spacing: 15){
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50.0, height: 50.0)
                    })
                    
                    Text(RatingModel.userLocation == nil ? "Locating..." : "Viewing At")
                        .foregroundColor(.black)
                    
                    Text(RatingModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)

                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing: 15){
                    TextField("Search", text: $RatingModel.search)
                    
                    if RatingModel.search != ""{
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                                
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                
                Divider()
                
                ScrollView(.vertical,showsIndicators: false, content:{
                    VStack(spacing: 25){
                        ForEach(RatingModel.items){ item in
                            // Restaurant Item view

                            // Text(item.item_name)
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                RestaurantItemView(item: item)
                                
                                HStack{
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "star.leadinghalf.fill")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color(.systemPink))
                                            .clipShape(Circle())
                                    })
                                    .padding(.leading,10)
                                    .padding(.top,10)
                                    
                                    Spacer(minLength: 0)
                                }
                            })
                            .frame(width: UIScreen.main.bounds.width - 30)
                        }                        
                    }
                    .padding(.top,10)
                })
            }
            
            if RatingModel.noLocation{
                Text("Please Enable Location Access In Settings :)")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            // Calling location delegate
            RatingModel.locationManager.delegate = RatingModel
        })
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView()
    }
}
