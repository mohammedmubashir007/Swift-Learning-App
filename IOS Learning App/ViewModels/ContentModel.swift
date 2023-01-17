import Foundation

class ContentModel:ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // current modules
    @Published var currentModule : Module?
    var currentModuleIndex = 0
    
    // current lesson
    @Published var currentLesson : Lesson?
    var currentLessonIndex = 0
    
    // current lesson explaination
    @Published var lessonDescription = NSAttributedString()
    
    
    var styleData : Data?
    
    
    // current selected lesson and test
    @Published var currentContentSelected : Int?
    
    
    init(){
        getLocalData()
    }
    
    
    //MARK: DATA METHODS
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
    
    
    
    //MARK: MODULE NAVIGATION METHODS
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
    
    
    
    //MARK: LESSON NAVIGATION METHODS
    func beginLesson(_ lessonIndex: Int){
        
        //check if the lesson id is in the range of the module
        if lessonIndex < currentModule!.content.lessons.count {
            
            currentLessonIndex = lessonIndex
        }else {
            currentLessonIndex = 0
        }
        
        
        //set the current lesson
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    
    
    //MARK: CHECK IF NEXT LESSON IS AVAILABLE OR NOT
    func hasNextLesson ()->Bool {
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }else{
            return false
        }
    }
    
    
    func nextLesson() {
        
        // advance lesson index
        
        currentLessonIndex += 1
        
        // check if the lesson is within the range
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // set the current lesson
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }else {
            currentLesson = nil
            currentLessonIndex = 0
        }
    }
    
    
    
    // MARK: Code styling
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the style data
        
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the html data
        
        data.append(Data(htmlString.utf8))
        
        // Convert to Attributed String
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        
        
        
        
        return resultString
    }
    
}
