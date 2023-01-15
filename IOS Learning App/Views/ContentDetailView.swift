import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            
            //only show url if you have a valid video url
            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
                
            }
            
            //TODO: Description
            
            CodeTextView()
            
            
            
            
            // Show button only if there is a next lesson
            if model.hasNextLesson(){
                
                Button(action: {
                    model.nextLesson()
                }, label: {
                    
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(.white)
                            .bold()
                        
                    }
                })
            }
        }.padding().navigationBarTitle(lesson?.title ?? "")
    }
}

//
//struct ContentDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentDetailView().environmentObject(ContentModel())
//    }
//}
