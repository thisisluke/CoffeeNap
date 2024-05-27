//
//  HomeViewModel.swift
//  CoffeeNap
//
//  Created by Luke Liu on 18/5/2024.
//

import Combine
import Foundation

final class HomeViewModel {
    @Published var sections: [HomeSection] = []
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
            let sections = try decoder.decode([HomeSection].self, from: data)
            self.sections = sections
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}

struct HomeSection: Codable, Hashable {
    let id: String
    let order: Int
    let title: String
    let items: [HomeItem]
}

struct HomeItem: Codable, Hashable {
    let id: String
    let icon: String
    let title: String
    let subtitle: String
    let color: String
}
