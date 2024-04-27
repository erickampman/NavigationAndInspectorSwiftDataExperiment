//
//  AuthorListView.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import SwiftUI
import SwiftData

struct AuthorListView: View {
	@Environment(\.modelContext) private var modelContext
	@Query private var authors: [Author]
	@Binding var navigationPath: NavigationPath
	@State private var selection = Author?.none
	@State private var inspecting = false
	@State private var showingAddAuthor = false

    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Authors")
					.font(.title2)
				Button("Add Author", systemImage: "plus") {
					showingAddAuthor.toggle()
				}
			}
			List(authors, id: \.self, selection: $selection) { author in
				Text(author.fullName)
			}
			.onChange(of: selection) {
				inspecting = selection != nil
			}
		}
		.inspector(isPresented: $inspecting) {
			if (selection == nil) {
				EmptyView()
			} else {
				AuthorView(author: selection!, navigationPath: $navigationPath, inspecting: $inspecting)
			}
		}
		.sheet(isPresented: $showingAddAuthor) {
			AddAuthorView(showingAddAuthor: $showingAddAuthor)
		}
	}
}

#Preview {
	@State var navigationPath = NavigationPath()

    return AuthorListView(navigationPath: $navigationPath)
}
