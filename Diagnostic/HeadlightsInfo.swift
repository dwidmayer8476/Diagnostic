//
//  Untitled.swift
//  Diagnostic
//
//  Created by Dylan J. Widmayer on 3/9/26.
//
import SwiftUI

struct HeadLightsViewHelper: View {
    var body: some View {
        ScrollView {
        Text("""
            1. Purpose
            
            Headlights are a critical part of a vehicle’s visibility and safety system. They illuminate the road ahead in low-light conditions such as nighttime, fog, rain, or snow. Headlights also make the vehicle more visible to other drivers.
            
            2. Main Components
            
            Headlight Bulb or LED Unit – The light source that produces illumination.
            Headlight Housing – The enclosure that protects internal components.
            Reflector or Projector Lens – Directs and focuses the light beam onto the road.
            Wiring and Connectors – Deliver electrical power to the headlights.
            Headlight Switch / Control Module – Allows the driver or system to turn headlights on and off.
            
            3. Common Types of Headlights
            
            Halogen Headlights
            Most common in older vehicles.
            Uses a tungsten filament and halogen gas.
            Lower cost but shorter lifespan.
            HID (High-Intensity Discharge) / Xenon
            Produces light using an electric arc between electrodes.
            Brighter and more energy efficient than halogen.
            Requires a ballast to regulate voltage.
            LED Headlights
            Modern and highly efficient.
            Long lifespan and very bright.
            Common in newer vehicles.
            
            4. Signs of Headlight Issues
            
            A diagnostic report may note the following symptoms:
            Dim headlights – Reduced brightness compared to normal.
            One headlight not working – Often caused by a burned-out bulb or wiring issue.
            Flickering lights – Electrical or connection problems.
            Cloudy or yellowed headlight lenses – Oxidation of the plastic housing.
            Misaligned beams – Headlights point too high, low, or to one side.
            
            5. Causes of Headlight Failure
            
            Common reasons headlights stop functioning correctly include:
            Burned-out bulb or LED module
            Damaged wiring or loose connectors
            Faulty fuse or relay
            Weak vehicle battery or charging system
            Oxidized headlight lenses reducing light output
            Faulty headlight switch or control module
            
            6. Diagnostic Inspection Steps
            
            A technician performing a headlight diagnostic might:
            Check if both low beams and high beams operate properly.
            Inspect the headlight bulbs for burnout or damage.
            Examine the headlight housing for cracks, moisture, or oxidation.
            Test fuses, relays, and electrical connections.
            Verify headlight alignment and beam direction.
            
            7. Recommended Solutions
            
            Depending on the findings, the diagnostic report may recommend:
            Replacing burned-out bulbs or LED modules.
            Cleaning or restoring oxidized headlight lenses.
            Repairing damaged wiring or connectors.
            Replacing faulty fuses or relays.
            Adjusting headlight alignment for proper road illumination.
            """)
        }
    }
}
#Preview {
    HeadLightsViewHelper()
}
