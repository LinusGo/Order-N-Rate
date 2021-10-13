//
//  RestaurantItemView.swift
//  RestaurantApp
//
//  Created by Linus Wang on 4/30/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantItemView: View {
    var item: RestaurantItem
    var body: some View {
        VStack{
            // Downloading Image from web
            
            WebImage(url:URL(string:item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 275)
            
            HStack(spacing: 6){
                
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                ForEach(1...5,id: \.self){ index in
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(index <= Int(item.item_cost) ?? 0 ?
                                            Color(.purple): .gray)
                }
            }
            
            HStack(spacing: 6){
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                Spacer(minLength: 0)
                
                ForEach(1...5,id: \.self){ index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ?
                                            Color(.red): .gray)
                }
            }
            
            Spacer()
        }
    }
}
