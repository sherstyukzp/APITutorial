//
//  ContentView.swift
//  
//
//  Created by Ярослав Шерстюк on 13.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var results = [Podcast]()
    
    var body: some View {
        
        NavigationView {
            
            List(results, id: \.id) { item in
                
                NavigationLink(destination: DetailView(itemSelect: item)) {
                    VStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                
                                RemoteImage(url: item.images.default!.absoluteString)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.secondary, lineWidth: 2))
                                    .shadow(radius: 10)
                                    .padding([.top, .bottom, .trailing])
                                
                                if item.isExclusive {
                                    Image ("ic_exclusive")
                                        .resizable()
                                        .frame(width: 100, height: 100, alignment: .center)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.secondary, lineWidth: 2))
                                        .padding([.top, .bottom, .trailing])
                                    
                                }
                            }
                            
                            VStack (alignment: .leading){
                                Text(item.title)
                                    .font(.largeTitle)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(1)
                                HStack {
                                    Text(item.publisherName)
                                    Spacer()
                                    if item.hasFreeEpisodes {
                                        Text("FREE")
                                            .foregroundColor(.white)
                                            .background(Color(.red))
                                            .font(.callout)
                                            
                                        
                                    }
                                }
                                
                                Divider()
                                Text(item.categoryName).foregroundColor(.orange)
                            }
                        }
                    }
                }
                
            }
            .onAppear(perform: loadData)
        
            .navigationTitle(Text ("Podcast"))
            
        }
        
    }
    
    
    func loadData() {
        guard let url = URL(string: "https://601f1754b5a0e9001706a292.mockapi.io/podcasts") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response = try? JSONDecoder().decode([Podcast].self, from: data) {
                    DispatchQueue.main.async {
                        self.results = response
                    }
                    return
                }
            }
        }.resume()
    }
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
