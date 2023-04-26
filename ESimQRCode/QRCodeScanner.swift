//
//  QRCodeScanner.swift
//  ESimQRCode
//
//  Created by Zeeshan Ahmed on 20/04/2023.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var qrCode: String = ""
    
    var handler: (String) -> Void = { (_) in
        
    }
    
    init() {
        handler = { (value) in
            print(value)
        }
    }
}

struct QRCodeScanner: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            QrCodeScannerView()
                .found(r: viewModel.handler)
            .torchLight(isOn: false)
            .interval(delay: 0.2)
            
            Text(viewModel.qrCode)
                .background(Color.black)
        }
        
    }
}

struct QRCodeScanner_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeScanner()
    }
}
