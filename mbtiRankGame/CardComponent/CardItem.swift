//
//  CardItem.swift
//  mbtiRankGame
//
//  Created by 박종후 on 2022/05/15.
//

import SwiftUI

struct CardItem: View {
    
    var firstCard: Bool
    var isFirst: Bool
    var targetText: String
    var targetCount: Int
    var isShowCount: Bool
    
    @State private var cardX: CGFloat = UIScreen.main.bounds.width
    @State private var topCardY:CGFloat = CGFloat(150)
    @State private var secCardY:CGFloat = CGFloat(150 + UIScreen.main.bounds.height * 0.4)
    
    var body: some View {
        RoundedRectangle(cornerRadius: 3)
            .fill(self.firstCard ? Color.red:Color.blue)
            .frame(height: UIScreen.main.bounds.height * 0.4)
            .animation(.default, value: self.isFirst)
            .overlay(
                VStack{
                    Text(targetText)
                    if self.isShowCount{
                        Text(String(targetCount))
                    }else{
                        Text("")
                    }
                }
                
            )
            .position(x: UIScreen.main.bounds.width / 2, y: self.isFirst ? self.secCardY: self.topCardY)
    }
}

struct CardItem_Previews: PreviewProvider {
    static var previews: some View {
        CardItem(firstCard: false, isFirst: false, targetText: "Hello", targetCount: 100, isShowCount: true)
    }
}
