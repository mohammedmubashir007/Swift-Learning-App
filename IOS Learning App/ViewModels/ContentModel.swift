//
//  ContentModel.swift
//  IOS Learning App
//
//  Created by Mohammed Mubashir on 06/01/23.
//

import Foundation

class ContentModel:ObservableObject {
    
    
    @Published var modules = [Module]()
    var styleData : Data?
    
    
    init(){
        getLocalData()
    }
    
    func getLocalData(){
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            self.modules = modules
            
        }
        catch{
            print("Error in making data object")
        }
        
        let parseStyle = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: parseStyle!)
            self.styleData = styleData
        }
        catch {
            
            print("Error in parsing Style data")
            
        }
        
    }
    
}
