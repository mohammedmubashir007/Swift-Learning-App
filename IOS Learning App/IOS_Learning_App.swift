//
//  IOS_Learning_AppApp.swift
//  IOS Learning App
//
//  Created by Mohammed Mubashir on 06/01/23.
//

import SwiftUI

@main
struct IOS_Learning_App: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
