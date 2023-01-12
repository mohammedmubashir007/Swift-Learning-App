//
//  ContentView.swift
//  IOS Learning App
//
//  Created by Mohammed Mubashir on 06/01/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model : ContentModel
    
    var body: some View {
        
        
        NavigationView {
            VStack (alignment: .leading){
                
                Text("What do you want to do today?")
                    .padding(.leading,20)
                
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            // learning card
                            
                            VStack(spacing: 20) {
                                
                                
                                NavigationLink {
                                    ContentView().onAppear {
                                        model.beginModule(module.id)
                                    }
                                } label: {
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) lessons", time: module.content.time)
                                }
                                
                                
                                
                                
                                
                                //test card
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) questions", time: module.test.time)
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
            }
            .navigationTitle("Get Started")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
