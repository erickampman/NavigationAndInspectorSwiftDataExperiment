//
//  NavigationAndInspectorSwiftDataExperimentApp.swift
//  NavigationAndInspectorSwiftDataExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

@main
struct NavigationAndInspectorSwiftDataExperimentApp: App {
	
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
			Book.self,
			Author.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
