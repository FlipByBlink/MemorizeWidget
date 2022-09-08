
import SwiftUI

struct 🧑‍💻AboutDeveloperPublisherLink: View {
    var body: some View {
        NavigationLink {
            🧑‍💻AboutDeveloperPublisherMenu()
        } label: {
            Label("Developer / Publisher", systemImage: "person")
        }
    }
}

struct 🧑‍💻AboutDeveloperPublisherMenu: View {
    var body: some View {
        List {
            Section {
                Text("Individual")
            } header: {
                Text("The System")
            }
            
            
            Section {
                Text("山下 亮")
                
                Text("やました りょう (ひらがな)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text("Yamashita Ryo (alphabet)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } header: {
                Text("Name")
            } footer: {
                Text("only one person")
            }
            
            
            Section {
                Text("age")
                    .badge("about 28")
                
                Text("country")
                    .badge("Japan")
                
                Text("native language")
                    .badge("Japanese")
            } header: {
                Text("identity / circumstance / background")
            } footer: {
                Text("As of 2021")
            }
            
            
            📆TimelineSection()
            
            
            Section {
                Image("Developer_Publisher")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    .opacity(0.6)
            } header: {
                Text("Image")
            } footer: {
                Text("Taken on 2021-11")
            }
        }
        .navigationTitle("Developer / Publisher")
    }
}

struct 📆TimelineSection: View {
    var 📃Text: [[String]] = 📆TimelineText
    
    var body: some View {
        Section {
            ForEach(📃Text, id: \.self) { 📃 in
                HStack {
                    Text(📃.first ?? "🐛")
                        .font(.caption2)
                        .padding(8)
                    Text(LocalizedStringKey(📃.last ?? "🐛"))
                        .font(.caption)
                }
            }
        } header: {
            Text("Timeline")
        }
    }
}

let 📆TimelineText: [[String]] =
[["2013-04","Finished from high school in Okayama Prefecture. Entranced into University-of-the-Ryukyus/faculty-of-engineering in Okinawa Prefecture."],
 ["2018-06","Final year as an undergraduate student. Developed an iOS application(FlipByBlink) as software for the purpose of research experiments."],
 ["2019-01","Released ebook reader app \"FlipByBlink\" ver 1.0 on AppStore. Special feature is to turn a page by slightly-longish-voluntary-blink."],
 ["2019-03","Graduated from University-of-the-Ryukyus."],
 ["2019-05","Released alarm clock app with taking a long time \"FadeInAlarm\" ver 1.0. First paid app."],
 ["2019-07","Migrated to Okayama Prefecture."],
 ["2021-12","Released FlipByBlink ver 3.0 for the first time in three years since ver 2.0."],
 ["2022-02","Released FadeInAlarm ver 2.0 for the first time in three years since ver 1.0."],
 ["2022-04","Released simple shogi board app \"PlainShogiBoard\" ver 1.0."],
 ["2022-05","Released body weight registration app \"TapWeight\" ver 1.0."],
 ["2022-06","Released body temperature registration app \"TapTemperature\" ver 1.0."],
 ["2022-06","Adopted In-App Purchase model for the first time on TapWeight ver 1.1.1"]]
