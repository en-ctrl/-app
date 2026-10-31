import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: BookkeepingStore
    @State private var showingPDF = false

    var body: some View {
        NavigationStack {
            List {
                Section("外觀") {
                    HStack {
                        Label("系統明暗模式", systemImage: "circle.lefthalf.filled")
                        Spacer()
                        Text("跟隨 iPhone")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("資料") {
                    Button {
                        showingPDF = true
                    } label: {
                        Label("匯出 PDF", systemImage: "doc.richtext")
                    }
                }

                Section("帳戶") {
                    HStack {
                        Text("目前紀錄")
                        Spacer()
                        Text("\(store.transactions.count) 筆")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("設定")
        }
        .sheet(isPresented: $showingPDF) {
            PDFExportView(transactions: store.transactions)
        }
    }
}

struct PDFExportView: View {
    let transactions: [Transaction]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "doc.richtext")
                    .font(.system(size: 50))
                Text("PDF 匯出")
                    .font(.title.bold())
                Text("這個專案已預留 PDF 匯出介面；正式版可接入 PDFKit 產生完整報表。")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
                    .padding()
                Button("關閉") { dismiss() }
            }
            .padding()
        }
    }
}
