//
//  DrawLive.swift
//  GreekKino
//
//  Created by Marko on 30.6.24..
//

import SwiftUI

struct DrawLive: View {
    let url: String = "https://www.mozzartbet.com/sr/lotto-animation/26#/"
    var body: some View {
        SwiftUIWebView(url: url)
    }
}

//#Preview {
//    DrawLive()
//}
