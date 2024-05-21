//
//  HomeViewModel.swift
//  CoffeeNap
//
//  Created by Luke Liu on 18/5/2024.
//

import Combine
import Foundation

final class HomeViewModel {
    @Published var sections: [Int: [HomeItem]] = [:]
    var cancellables: Set<AnyCancellable> = []

    init() {
        self.loadData()
    }

    private func loadData() {
        guard let url = Bundle.main.url(forResource: "home", withExtension: "json") else {
            print("Failed to locate home.json in the bundle.")
            return
        }

        let decoder = JSONDecoder()

        do {
            let data = try Data(contentsOf: url)
            let items = try decoder.decode([HomeItem].self, from: data)
            self.organizeItemsBySection(items: items)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    private func organizeItemsBySection(items: [HomeItem]) {
        let groupedItems = Dictionary(grouping: items) { $0.section }

        self.sections = groupedItems.mapValues { group in
            group.sorted { $0.title.localizedCompare($1.title) == .orderedAscending }
        }

        self.sections = self.sections.sorted(by: { $0.key < $1.key }).reduce(into: [:]) { result, tuple in
            result[tuple.key] = tuple.value
        }
    }
}

struct HomeItem: Codable, Hashable {
    let id: String
    let icon: String
    let title: String
    let subtitle: String
    let color: String
    let section: Int
}
