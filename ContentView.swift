//
//  ContentView.swift
//  mbtiRankGame
//
//  Created by 박종후 on 2022/05/15.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GameView(data:ModelData().stageList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
