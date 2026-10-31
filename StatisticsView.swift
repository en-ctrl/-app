import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject private var store: BookkeepingStore

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    GlassCard {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("本月支出")
                                .foregroundStyle(.secondary)
                            Text("$\(store.monthExpense, specifier: "%.0f")")
                                .font(.largeTitle.bold())
                            HStack {
                                Text("收入")
                                Spacer()
                                Text("$\(store.monthIncome, specifier: "%.0f")")
                            }
                            HStack {
                                Text("結餘")
                                Spacer()
                                Text("$\(store.monthIncome - store.monthExpense, specifier: "%.0f")")
                            }
                        }
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("分類排行榜")
                                .font(.headline)
                            ForEach(Category.allCases) { category in
                                let total = store.transactions(for: category)
                                    .filter { Calendar.current.isDate($0.date, equalTo: .now, toGranularity: .month) }
                                    .reduce(0) { $0 + $1.amount }
                                HStack {
                                    Label(category.rawValue, systemImage: category.symbol)
                                    Spacer()
                                    Text("$\(total, specifier: "%.0f")")
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("統計")
        }
    }
}
