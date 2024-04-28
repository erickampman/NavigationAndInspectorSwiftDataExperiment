//
//  Data.swift
//  NavigationAndInspectorExperiment
//
//  Created by Eric Kampman on 4/26/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
public class Book: Identifiable, Hashable {
	public static func == (lhs: Book, rhs: Book) -> Bool {
		let left = lhs.title + lhs.author.id.uuidString
		let right = rhs.title + rhs.author.id.uuidString
		
		return left == right
	}
	
	public func hash(into hasher: inout Hasher) {
		hasher.combine(title)
		hasher.combine(author)
	}

	init(title: String, author: Author) {
		self.title = title
		self.author = author
	}

	init(title: String, authorFirst: String, authorLast: String) {
		self.title = title
		let author = Author(firstName: authorFirst, lastName: authorLast)
		self.author = author
	}

	var title: String
	@Relationship(deleteRule: .noAction, inverse: \Author.books)
	var author: Author
	
	public var id: UUID = UUID()
	
	var bookDescription: String {
		return "\(title) by \(author.fullName)"
	}
}

@Model
public class Author: Identifiable, Hashable {
	public static func == (lhs: Author, rhs: Author) -> Bool {
		return lhs.id == rhs.id
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	var firstName: String
	var lastName: String
	
	@Relationship(deleteRule: .cascade)
	var books = [Book]()
	
	public let id: UUID = UUID()
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	init() {
		self.firstName = ""
		self.lastName = ""
	}
	
	var fullName: String {
		return ("\(firstName) \(lastName)")
	}
	
	func updateValuesWith(_ author: Author) {
		self.firstName = author.firstName
		self.lastName = author.lastName
	}


}

