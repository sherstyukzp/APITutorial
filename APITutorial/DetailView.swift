//
//  DetailView.swift
//  
//
//  Created by Ярослав Шерстюк on 14.04.2021.
//

import SwiftUI

struct DetailView: View {
    
    let itemSelect: Podcast
    
    var body: some View {
        
        VStack {
            RemoteImage(url: itemSelect.images.default!.absoluteString)
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.secondary, lineWidth: 2))
                .shadow(radius: 10)
            Text("\(itemSelect.publisherName)").font(.title)
            Text("\(itemSelect.playSequence)")
            Divider()
            HStack(alignment: .center) {
                Text("Description")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.leading)
                Spacer()
                
            }
            
                
            Text("\(itemSelect.description)")
                .padding()
                .foregroundColor(.gray)

            Spacer ()
        }
            
            
            .navigationTitle(Text("\(itemSelect.title)"))
        
        
        
    }
}


