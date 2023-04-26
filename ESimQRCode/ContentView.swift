//
//  ContentView.swift
//  ESimQRCode
//
//  Created by Zeeshan Ahmed on 19/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    var body: some View {
        VStack(alignment: .center) {
            TextField("Enter Something", text: $text)
            
            Image(uiImage: createQRCode(qrtext: $text))
                .interpolation(.none)
                .resizable()
                .foregroundColor(Color.red)
                .frame(width: 200, height: 200)
        }
    }
    
    func createQRCode(qrtext: Binding<String>) -> UIImage {
        QRCodeGenerator()
            .generateQRCode(from: qrtext.wrappedValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
