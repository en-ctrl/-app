import Foundation
import SwiftUI

enum TransactionType: String, CaseIterable, Codable {
    case expense = "支出"
    case income = "收入"
}

enum Category: String, CaseIterable, Codable, Identifiable {
    case breakfast = "早餐"
    case transport = "交通"
    case dinner = "晚餐"
    case study = "學習"
    case lodging = "住宿"
    case medical = "醫療"
    case other = "其他"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .breakfast: "fork.knife"
        case .transport: "bus.fill"
        case .dinner: "fork.knife"
        case .study: "book.fill"
        case .lodging: "bed.double.fill"
        case .medical: "cross.case.fill"
        case .other: "ellipsis"
        }
    }
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    var type: TransactionType
    var amount: Double
    var date: Date
    var note: String
    var category: Category

    init(
        id: UUID = UUID(),
        type: TransactionType,
        amount: Double,
        date: Date = .now,
        note: String = "",
        category: Category
    ) {
        self.id = id
        self.type = type
        self.amount = amount
        self.date = date
        self.note = note
        self.category = category
    }
}

final class BookkeepingStore: ObservableObject {
    @Published var transactions: [Transaction] {
        didSet { save() }
    }

    private let key = "bookkeeping.transactions.v1"

    init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode([Transaction].self, from: data) {
            transactions = saved.sorted { $0.date > $1.date }
        } else {
            transactions = []
        }
    }

    func add(_ transaction: Transaction) {
        transactions.insert(transaction, at: 0)
    }

    func delete(_ transaction: Transaction) {
        transactions.removeAll { $0.id == transaction.id }
    }

    func update(_ transaction: Transaction) {
        guard let index = transactions.firstIndex(where: { $0.id == transaction.id }) else { return }
        transactions[index] = transaction
        transactions.sort { $0.date > $1.date }
    }

    var balance: Double {
        transactions.reduce(0) { $0 + ($1.type == .income ? $1.amount : -$1.amount) }
    }

    var todayIncome: Double {
        sum(type: .income, in: Calendar.current.startOfDay(for: .now)...Date())
    }

    var todayExpense: Double {
        sum(type: .expense, in: Calendar.current.startOfDay(for: .now)...Date())
    }

    var monthIncome: Double {
        sum(type: .income, in: monthRange)
    }

    var monthExpense: Double {
        sum(type: .expense, in: monthRange)
    }

    private var monthRange: ClosedRange<Date> {
        let calendar = Calendar.current
        let start = calendar.date(from: calendar.dateComponents([.year, .month], from: .now))!
        let end = calendar.date(byAdding: DateComponents(month: 1, second: -1), to: start)!
        return start...end
    }

    func sum(type: TransactionType, in range: ClosedRange<Date>) -> Double {
        transactions
            .filter { $0.type == type && range.contains($0.date) }
            .reduce(0) { $0 + $1.amount }
    }

    func transactions(for category: Category) -> [Transaction] {
        transactions.filter { $0.category == category && $0.type == .expense }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(transactions) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
