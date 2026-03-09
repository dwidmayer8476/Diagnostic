//
//  Untitled.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 3/9/26.
//
import SwiftUI
struct WiperBladesViewHelper: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("All About Wiper Blades")
                    .font(.largeTitle)
                    .padding(.bottom)
                Text("""
                    1. Purpose
                    
                    Windshield wiper blades are part of a vehicle’s visibility and safety system. Their job is to remove rain, snow, dirt, and debris from the windshield so the driver can see clearly. They work together with the wiper motor, wiper arms, and washer fluid system.
                    
                    2. Main Components
                    
                    Rubber blade – The flexible rubber edge that wipes water and debris from the glass.
                    Frame or beam structure – Holds the rubber blade and distributes pressure across the windshield.
                    Wiper arm connection – The clip or hook that attaches the blade to the wiper arm.
                    
                    3. Common Types of Wiper Blades
                    
                    Conventional (Frame) Blades
                    Metal frame with multiple pressure points.
                    Usually the cheapest type.
                    More prone to corrosion or clogging with ice/snow.
                    Beam Blades
                    One solid curved piece without an external frame.
                    Better pressure distribution.
                    More durable in harsh weather.
                    Hybrid Blades
                    Combination of frame and beam design.
                    Aerodynamic cover improves performance at high speeds.
                    
                    4. Signs of Worn or Faulty Wiper Blades
                    
                    A diagnostic report may note the following symptoms:
                    Streaking – Lines of water left behind after wiping.
                    Skipping or chattering – Blade jumps across the windshield.
                    Squeaking noise – Often caused by hardened rubber.
                    Uneven wiping – Parts of the windshield remain wet.
                    Visible damage – Cracks, tears, or missing rubber sections.
                    
                    5. Causes of Wiper Blade Failure
                    
                    Common reasons wiper blades stop working effectively include:
                    Rubber degradation from sunlight (UV exposure)
                    Extreme temperatures (heat or freezing conditions)
                    Dirt or debris buildup on the blade edge
                    Improper installation or worn wiper arms
                    Normal wear over time
                    Most manufacturers recommend replacing blades every 6–12 months.
                    
                    6. Diagnostic Inspection Steps
                    
                    A technician performing a diagnostic check might:
                    Visually inspect the blade rubber for cracks, splits, or stiffness.
                    Check if the blade maintains full contact with the windshield.
                    Run the wipers to observe streaking, noise, or skipping.
                    Inspect the wiper arm tension and alignment.
                    Verify the washer fluid system is functioning correctly.
                    
                    7. Recommended Solutions
                    
                    Depending on the findings, the report may recommend:
                    Cleaning the blades with alcohol or washer fluid.
                    Replacing worn wiper blades with the correct size and type.
                    Adjusting or replacing wiper arms if pressure is insufficient.
                    Checking the wiper motor or linkage if motion is abnormal.
                    """)
            }
            .padding()
        }
    }
}
