import SwiftUI
import UIKit

struct PDFGenerator {
    static func createTestPDF(
        vin: String, make: String, mileage: String,
        brakes: String, tires: String, engine: String,
        technician: String
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
            }
            print("PDF generated at: \(url)")
            return url
        } catch {
            print("Failed to write PDF:", error)
            return nil
        }
    }
}


