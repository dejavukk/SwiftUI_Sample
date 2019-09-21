//
//  ContentView.swift
//  SwiftUI_Sample
//
//  Created by JunHyuk on 21/09/2019.
//  Copyright © 2019 junhyuk. All rights reserved.
//

import SwiftUI

// 뷰와 레이아웃부분 구조체.
struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Make the app, Using Swift UI!!")
                .fontWeight(.semibold)
                .foregroundColor(.green)
            
            
            
            // 버튼 UI구현, log출력.
            Button(action: {
                print("Button Pressed")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("Hello SwiftUI!!"), message: Text("SwiftUI로 구현한 Alert."), dismissButton: .default(Text("확인")))
            }
        }
    }
}

// 해당 뷰에 대한 미리보기 부분 역시 구조체로 선언되어 있다. macOS 10.15버전 이후부터 제공.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        
    }
}
