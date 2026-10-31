import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var store: BookkeepingStore
    @State private var query = ""

    private var results: [Transaction] {
        guard !query.isEmpty else { return store.transactions }
        return store.transactions.filter {
            $0.note.localizedCaseInsensitiveContains(query) ||
            $0.category.rawValue.localizedCaseInsensitiveContains(query) ||
            String(format: "%.0f", $0.amount).contains(query)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(results) { item in
                    HStack {
                        Image(systemName: item.category.symbol)
                        VStack(alignment: .leading) {
                            Text(item.note.isEmpty ? item.category.rawValue : item.note)
                            Text(item.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text("$\(item.amount, specifier: "%.0f")")
                            .foregroundStyle(item.type == .expense ? .red : .green)
                    }
                }
                .onDelete { offsets in
                    for index in offsets {
                        store.delete(results[index])
                    }
                }
            }
            .searchable(text: $query, prompt: "搜尋交易、分類或金額")
            .navigationTitle("搜尋")
        }
    }
}
