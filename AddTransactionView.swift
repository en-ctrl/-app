import SwiftUI

struct AddTransactionView: View {
    @EnvironmentObject private var store: BookkeepingStore
    @Environment(\.dismiss) private var dismiss

    @State private var type: TransactionType = .expense
    @State private var amount = ""
    @State private var category: Category = .breakfast
    @State private var note = ""
    @State private var date = Date.now

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    Picker("類型", selection: $type) {
                        ForEach(TransactionType.allCases, id: \.self) { Text($0.rawValue) }
                    }
                    .pickerStyle(.segmented)

                    GlassCard {
                        TextField("金額", text: $amount)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                    }

                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Label("分類", systemImage: "tag")
                                .font(.headline)

                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                ForEach(Category.allCases) { item in
                                    Button {
                                        category = item
                                    } label: {
                                        VStack(spacing: 7) {
                                            Image(systemName: item.symbol)
                                            Text(item.rawValue)
                                                .font(.caption)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            category == item
                                            ? Color.blue.opacity(0.16)
                                            : Color.primary.opacity(0.04),
                                            in: RoundedRectangle(cornerRadius: 16)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }

                    GlassCard {
                        VStack(spacing: 14) {
                            TextField("備註（選填）", text: $note)
                            DatePicker("日期／時間", selection: $date)
                        }
                    }

                    PrimaryGlassButton(title: "儲存", systemImage: "checkmark") {
                        guard let value = Double(amount), value > 0 else { return }
                        store.add(Transaction(
                            type: type,
                            amount: value,
                            date: date,
                            note: note,
                            category: category
                        ))
                        dismiss()
                    }
                }
                .padding()
            }
            .navigationTitle("新增記帳")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("取消") { dismiss() }
                }
            }
        }
    }
}
