//
//  ContentModel.swift
//  IOS Learning App
//
//  Created by Mohammed Mubashir on 06/01/23.
//

import Foundation

class ContentModel:ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // current modules
    @Published var currentModule : Module?
    var currentModuleIndex = 0
    
    var styleData : Data?
    
    
    init(){
        getLocalData()
    }
    
    
    //     MARK: DATA METHODS
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
    
    
    //MARK: NAVIGATION METHODS
    func beginModule(_ moduleId: Int){
        
        // find the index of the this module id
        
        for index in 0..<modules.count {
            if modules[index].id == moduleId {
                //found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
        
    }
}
