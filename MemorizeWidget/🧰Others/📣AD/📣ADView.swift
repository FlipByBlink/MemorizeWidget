
import SwiftUI

struct 📣ADView: View {
    @State private var 🄰ppName: 📣AppName
    
    var body: some View {
        Link(destination: 🄰ppName.🔗URL) {
            HStack(spacing: 12) {
                Image(🄰ppName.rawValue)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .shadow(radius: 1.5, y: 0.5)
                    .padding(.vertical, 40)
            
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(🄰ppName.rawValue)
                            .font(.headline)
                            .lineLimit(1)
                        
                        Image(systemName: "arrow.up.forward.app")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .minimumScaleFactor(0.1)
                    .padding(.trailing, 32)
                    
                    Text(🄰ppName.📄About)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.1)
                }
                .padding(.vertical)
            }
        }
        .accessibilityLabel("Open AD link")
        .padding(.leading, 4)
        .overlay(alignment: .topLeading) {
            Text("AD")
                .scaleEffect(x: 1.2)
                .font(.subheadline.weight(.black))
                .frame(maxHeight: 32)
                .minimumScaleFactor(0.1)
                .padding(.top, 8)
                .padding(.leading, 3)
                .foregroundStyle(.tertiary)
        }
    }
    
    init(_ ⓐppName: 📣AppName? = nil) {
        if let 🏷 = ⓐppName {
            🄰ppName = 🏷
        } else {
            🄰ppName = 📣AppName.allCases.randomElement()!
        }
    }
}
