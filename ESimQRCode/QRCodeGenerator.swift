//
//  QRCodeGenerator.swift
//  ESimQRCode
//
//  Created by Zeeshan Ahmed on 19/04/2023.
//

import CoreImage.CIFilterBuiltins
import UIKit

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String, color: UIColor = .black) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                var qrImage = UIImage(cgImage: cgimg)
                let transform = CGAffineTransform(scaleX: 10, y: 10)
                if let scaledQrImage = qrImage.ciImage?.transformed(by: transform) {
                    qrImage = UIImage(ciImage: scaledQrImage)
                }
                return qrImage
            
                // Setting the Colors
                let colorInvertFilter = CIFilter.colorInvert()
                colorInvertFilter.setValue(qrImage, forKey: kCIInputImageKey)
                guard let outputInvertedImage = colorInvertFilter.outputImage else { return qrImage }
                // Replace the black with transparency
                let maskToAlphaFilter = CIFilter.maskToAlpha()
                maskToAlphaFilter.setValue(outputInvertedImage, forKey: kCIInputImageKey)
                guard let outputCIImage = maskToAlphaFilter.outputImage else { return  qrImage}
                // Do some processing to get the UIImage
                let context = CIContext()
                guard let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) else { return qrImage }
                qrImage = UIImage(cgImage: cgImage)
                qrImage.withRenderingMode(.alwaysTemplate)
                return qrImage
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}
