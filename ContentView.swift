import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var store: BookkeepingStore
    @State private var selectedTab = 0
    @State private var showingAdd = false

    var body: some View {
        ZStack {
            AppBackground()

            TabView(selection: $selectedTab) {
                HomeView(showingAdd: $showingAdd)
                    .tabItem { Label("首頁", systemImage: "house.fill") }
                    .tag(0)

                Text("記帳")
                    .tabItem { Label("記帳", systemImage: "plus.circle.fill") }
                    .tag(1)

                StatisticsView()
                    .tabItem { Label("統計", systemImage: "chart.bar.xaxis") }
                    .tag(2)

                SearchView()
                    .tabItem { Label("搜尋", systemImage: "magnifyingglass") }
                    .tag(3)

                SettingsView()
                    .tabItem { Label("設定", systemImage: "gearshape") }
                    .tag(4)
            }
            .tint(.blue)
        }
        .sheet(isPresented: $showingAdd) {
            AddTransactionView()
                .environmentObject(store)
        }
        .onChange(of: selectedTab) { _, value in
            if value == 1 {
                selectedTab = 0
                showingAdd = true
            }
        }
    }
}

struct AppBackground: View {
    var body: some View {
        ZStack {
            Color(uiColor: .systemGroupedBackground)
            Circle()
                .fill(.blue.opacity(0.08))
                .frame(width: 280)
                .blur(radius: 40)
                .offset(x: 150, y: -300)
            Circle()
                .fill(.mint.opacity(0.07))
                .frame(width: 260)
                .blur(radius: 45)
                .offset(x: -160, y: 280)
        }
        .ignoresSafeArea()
    }
}
