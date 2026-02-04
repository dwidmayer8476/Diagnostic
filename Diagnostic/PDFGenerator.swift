import SwiftUI
import UIKit

struct PDFGenerator {
    static func createTestPDF(
        vin: String, make: String, mileage: String,
        brakes: String, tires: String, engine: String,
        technician: String,
        photo: UIImage? = nil
    ) -> URL? {
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("TestDiagnostic.pdf")
        
        try? FileManager.default.removeItem(at: url)

        do {
            try renderer.writePDF(to: url) { context in
                context.beginPage()

                let title = "Vehicle Diagnostic Report"
                title.draw(at: CGPoint(x: 40, y: 40), withAttributes: [.font: UIFont.boldSystemFont(ofSize: 24)])

                let body = """
                VIN: \(vin)
                Make: \(make)
                Mileage: \(mileage)

                Brakes: \(brakes)
                Tires: \(tires)
                Engine: \(engine)

                Technician: \(technician)
                """
                body.draw(in: CGRect(x: 40, y: 100, width: pageRect.width - 80, height: pageRect.height - 140),
                          withAttributes: [.font: UIFont.systemFont(ofSize: 16)])
            
                
                if let image = photo {
        
                    let inset: CGFloat = 40
                    let topY: CGFloat = 100
                    let spacing: CGFloat = 20

                    let imageAreaY = topY + 260
                    let maxImageRect = CGRect(
                        x: inset,
                        y: imageAreaY + spacing,
                        width: pageRect.width - inset * 2,
                        height: pageRect.height - (imageAreaY + spacing) - inset
                    )

                    
                    let imgSize = image.size
                    if imgSize.width > 0 && imgSize.height > 0 {
                        let widthScale = maxImageRect.width / imgSize.width
                        let heightScale = maxImageRect.height / imgSize.height
                        let scale = min(widthScale, heightScale)
                        let drawSize = CGSize(width: imgSize.width * scale, height: imgSize.height * scale)
                        let drawOrigin = CGPoint(
                            x: maxImageRect.midX - drawSize.width / 2,
                            y: maxImageRect.minY
                        )
                        let drawRect = CGRect(origin: drawOrigin, size: drawSize)
                        image.draw(in: drawRect)
                    }
                }
            }
            print("PDF generated at: \(url)")
            return url
        } catch {
            print("Failed to write PDF:", error)
            return nil
        }
    }
}


