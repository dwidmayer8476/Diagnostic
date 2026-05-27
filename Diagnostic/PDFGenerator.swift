import SwiftUI
import UIKit

struct PDFGenerator {
    /// Simplest API: Always returns Data ready to attach to Mail/Share.
    static func makeReportPDFData(
        vin: String,
        make: String,
        mileage: String,
        brakes: String,
        tires: String,
        engine: String,
        technician: String,
        photo: UIImage? = nil
    ) -> Data? {
        // Delegate to the tested data-based generator
        return createTestPDFData(
            vin: vin, make: make, mileage: mileage,
            brakes: brakes, tires: tires, engine: engine,
            technician: technician, photo: photo
        )
    }

    static func createTestPDFData(
        vin: String, make: String, mileage: String,
        brakes: String, tires: String, engine: String,
        technician: String,
        photo: UIImage? = nil
    ) -> Data? {
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let data = renderer.pdfData { context in
            context.beginPage()

            // optional visible border to avoid "looks blank"
            UIColor.black.setStroke()
            UIBezierPath(rect: pageRect.insetBy(dx: 1, dy: 1)).stroke()

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

            if let image = photo, image.size.width > 0, image.size.height > 0 {
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
        return data
    }

    static func createTestPDF(
        vin: String, make: String, mileage: String,
        brakes: String, tires: String, engine: String,
        technician: String,
        photo: UIImage? = nil
    ) -> URL? {
        let pageRect = CGRect(x: 0, y: 0, width: 612, height: 792)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)

        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent("TestDiagnostic_\(UUID().uuidString).pdf")
        
        try? FileManager.default.removeItem(at: url)

        do {
            // Generate the PDF as Data first
            guard let data = createTestPDFData(
                vin: vin, make: make, mileage: mileage,
                brakes: brakes, tires: tires, engine: engine,
                technician: technician, photo: photo
            ) else {
                return nil
            }
            try data.write(to: url, options: .atomic)
            print("PDF generated at: \(url)")
            return url
        } catch {
            print("Failed to write PDF:", error)
            return nil
        }
    }
}
