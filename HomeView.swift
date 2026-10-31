import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var store: BookkeepingStore
    @Binding var showingAdd: Bool
    @Binding var selectedTab: Int

    private let currency = "$"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    header
                    balanceCard
                    dailyCards
                    monthCard
                    availableCard
                    recentCard
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("記帳app")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                Text("記錄每一筆，掌握每一分")
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                selectedTab = 4
            } label: {
                Image(systemName: "gearshape")
                    .font(.title2)
                    .padding(12)
                    .background(.thinMaterial, in: Circle())
            }
            .buttonStyle(.plain)
        }
        .padding(.top, 8)
    }

    private var balanceCard: some View {
        GlassCard {
            HStack {
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 38))
                    .foregroundStyle(.blue)
                    .frame(width: 72, height: 72)
                    .background(.blue.opacity(0.10), in: RoundedRectangle(cornerRadius: 20))

                VStack(alignment: .leading, spacing: 4) {
                    Text("帳戶餘額").foregroundStyle(.secondary)
                    Text("\(currency)\(store.balance, specifier: "%.0f")")
                        .font(.system(size: 38, weight: .bold, design: .rounded))
                }
                Spacer()
            }
        }
    }

    private var dailyCards: some View {
        HStack(spacing: 12) {
            summary(title: "今日支出", value: store.todayExpense, color: .red, icon: "arrow.down")
            summary(title: "今日收入", value: store.todayIncome, color: .green, icon: "arrow.up")
        }
    }

    private func summary(title: String, value: Double, color: Color, icon: String) -> some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .foregroundStyle(color)
                    Text(title)
                        .foregroundStyle(.secondary)
                }
                Text("\(currency)\(value, specifier: "%.0f")")
                    .font(.title2.bold())
            }
        }
    }

    private var monthCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 14) {
                Label("本月統計", systemImage: "calendar")
                    .font(.headline)

                HStack {
                    metric("本月支出", store.monthExpense, .red)
                    Divider()
                    metric("本月收入", store.monthIncome, .green)
                    Divider()
                    metric("本月結餘", store.monthIncome - store.monthExpense, .blue)
                }
            }
        }
    }

    private func metric(_ title: String, _ value: Double, _ color: Color) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text("\(currency)\(value, specifier: "%.0f")")
                .font(.headline)
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var availableCard: some View {
        GlassCard {
            HStack {
                Image(systemName: "chart.pie.fill")
                    .foregroundStyle(.blue)
                VStack(alignment: .leading) {
                    Text("剩餘可用金額").foregroundStyle(.secondary)
                    Text("\(currency)\(store.monthIncome - store.monthExpense, specifier: "%.0f")")
                        .font(.title2.bold())
                }
                Spacer()
            }
        }
    }

    private var recentCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Label("最近交易", systemImage: "clock")
                        .font(.headline)
                    Spacer()
                    Button("查看全部") { selectedTab = 3 }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                if store.transactions.isEmpty {
                    ContentUnavailableView("尚無紀錄", systemImage: "tray")
                } else {
                    ForEach(Array(store.transactions.prefix(5))) { item in
                        HStack {
                            Image(systemName: item.category.symbol)
                                .frame(width: 38, height: 38)
                                .background(.blue.opacity(0.10), in: Circle())
                            VStack(alignment: .leading) {
                                Text(item.note.isEmpty ? item.category.rawValue : item.note)
                                    .font(.headline)
                                Text(item.date.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(item.type == .expense ? "-" : "+")\(currency)\(item.amount, specifier: "%.0f")")
                                .font(.headline)
                                .foregroundStyle(item.type == .expense ? .red : .green)
                        }
                    }
                }

                Picker("統計範圍", selection: .constant(0)) {
                    Text("每日").tag(0)
                    Text("每週").tag(1)
                    Text("每月").tag(2)
                }
                .pickerStyle(.segmented)
            }
        }
    }
}
