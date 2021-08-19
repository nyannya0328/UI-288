//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/08/19.
//

import SwiftUI

struct Home: View {
    @State var titletext : [TextAnimation] = []
    
    @State var titles = [
    
    "Clean your mind from",//,need
    "Unique experience",
    "The ultimate program",
    "Butiful Mountain"
    
    
    ]
    
    @State var subTitles = [
    
    "Negativity - stress - Anxiety",
    "Prepare your mind for sweet dream",
    "Healty mind - better sleep - well being",
    "The Moring coffee"
    
    
    ]
    
    @State var subtitleAnimation = false
    @State var endAnimation = false
    
    @State var currentIndex : Int = 3
    
    
    var body: some View {
        ZStack{
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                
                Color.red
                
                ForEach(1...4,id:\.self){index in
                    
                    
                    Image("p\(index)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .opacity(currentIndex == (index - 1) ? 1 : 0)
                    
                }
                
                
                LinearGradient(colors: [.clear,.black.opacity(0.3),.black], startPoint: .top, endPoint: .bottom)
                
                
            }
            .ignoresSafeArea()
            
            
            VStack(spacing:20){
                
                
                HStack(spacing:0){
                    
                    
                    ForEach(titletext){title in
                        
                        
                        Text(title.text)
                            .offset(y: title.offset)
                        
                    }
                    .font(.largeTitle.weight(.black))
                }
                .offset(y:endAnimation ? -100 : 0)
                .opacity(endAnimation ? 0 : 1)
                  
                
                Text(subTitles[currentIndex])
                    .offset(y: !subtitleAnimation ? 80 : 0)
                    .offset(y:endAnimation ? -100 : 0)
                    .opacity(endAnimation ? 0 : 1)
                
                
                SignButton(image: "applelogo", title: "Sing in With apple", isSystem: true) {
                    
                    
                }
                .padding(.top)
                
                SignButton(image: "google", title: "Sing in With google", isSystem: false) {
                    
                    
                }
                
                SignButton(image: "facebook", title: "Sing in With FB", isSystem: false) {
                    
                    
                }
                
                
                
                
                
                
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            
        }
        .onAppear {
            
            currentIndex = 0

        }
        .onChange(of: currentIndex) { newValue in
            
            
            getSplitedText(text: titles[currentIndex]) {
                
                
                withAnimation(.easeInOut(duration: 1)){
                    
                    endAnimation.toggle()
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    
                    
                    titletext.removeAll()
                    endAnimation.toggle()
                    subtitleAnimation.toggle()
                    
                    
                    
                    withAnimation(.easeInOut(duration: 0.6)){
                        
                        
                        if currentIndex < (titles.count - 1){
                            
                            currentIndex += 1
                        }
                        else{
                            
                            currentIndex = 0
                        }
                    }
                    
                    
                    
                }
                
            }
            
            
        }
    }
    
    func getSplitedText(text : String,compettion : @escaping()->()){
        
        
        for (index , currentIndex) in text.enumerated(){
            
            
            titletext.append(TextAnimation(text: String(currentIndex)))
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.03) {
                
                
                withAnimation(.easeIn(duration: 0.5)){
                    
                    
                  titletext[index].offset = 0
                }
            }
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(text.count) * 0.02) {
            
            withAnimation(.easeInOut(duration: 0.5)){
                
                
                subtitleAnimation.toggle()
                
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.95) {
                
                compettion()
                
            }
            
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SignButton : View{
    
    var image : String
    var title : String
    var isSystem : Bool
    var ontap :()->()
    
    var body: some View{
        
        HStack{
            
            (
            
            
                isSystem ? Image(systemName: image) : Image(image)
            
            )
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
        
            
            Text(title)
                .font(.title3.weight(.thin))
                .frame(maxWidth: .infinity)
            
              
            
            
        }
        
        .foregroundColor(!isSystem ? .white : .gray)
        .padding(.vertical,10)
        .padding(.horizontal,40)
        .background(
        
            .white.opacity(isSystem ? 1 : 0.1),in: Capsule()
        
        
        )
        .onTapGesture {
            ontap()
        }
        
        
    }
}
