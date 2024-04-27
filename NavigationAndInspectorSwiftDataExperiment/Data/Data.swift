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
		let left = lhs.title + lhs.author.id
		let right = rhs.title + rhs.author.id
		
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
	var author: Author
	
	public var id: String {
		String("\(title) by \(author.id)")
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
	
	var books: [Book]?
	
	public var id: String {
		return firstName + " " + lastName
	}
	
	init(firstName: String, lastName: String) {
		self.firstName = firstName
		self.lastName = lastName
	}
	
	init() {
		self.firstName = ""
		self.lastName = ""
	}
}

//public func setupData() {
//	@Environment(\.modelContext) var modelContext
//	@Query var books: [Book]
//	@Query var authors: [Author]
//
//	let timJones = Author(firstName: "Tim", lastName: "Jones")
//	let sallyFoo = Author(firstName: "Sally", lastName: "Foo")
//	let johnDoe = Author(firstName: "John", lastName: "Doe")
//	
//	if authors.isEmpty {
//		modelContext.insert(timJones)
//		modelContext.insert(sallyFoo)
//		modelContext.insert(johnDoe)
//	}
//	if books.isEmpty {
//		let jonesBook = Book(title: "Jones Book", author: timJones)
//		let jonesBook2 = Book(title: "Jones Book II", author: timJones)
//		let sallyBook = Book(title: "Sally Forth", author: sallyFoo)
//		let sallyBook2 = Book(title: "Sally Fifth", author: sallyFoo)
//		let anonymousBook = Book(title: "Anonymous", author: johnDoe)
//
//		modelContext.insert(jonesBook)
//		modelContext.insert(jonesBook2)
//		modelContext.insert(sallyBook)
//		modelContext.insert(sallyBook2)
//		modelContext.insert(anonymousBook)
//	}
//	
//}

//func findAuthor(first: String, last: String) -> Author? {
//	@Environment(\.modelContext) var modelContext
//	@Query var authors: [Author]
//
//	for author in authors {
//		if author.firstName == first &&
//			author.lastName == last
//		{
//			return author
//		}
//	}
//	return nil
//}
	

#if false	// remove library for swiftdata version
@Model
class Library: Identifiable, Hashable {
	var id = ""
	var authors = [Author]()
	var books = [Book]()
	
	static func == (lhs: Library, rhs: Library) -> Bool {
		lhs.id == rhs.id	// pretty lame. Should check books and authors
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	init(id: String = "") {
		self.id = id
	}
	func setData() {
		self.id = "My Library"
		
		let timJones = Author(firstName: "Tim", lastName: "Jones")
		let sallyFoo = Author(firstName: "Sally", lastName: "Foo")
		let johnDoe = Author(firstName: "John", lastName: "Doe")
		
		let jonesBook = Book(title: "Jones Book", author: timJones)
		let jonesBook2 = Book(title: "Jones Book II", author: timJones)
		let sallyBook = Book(title: "Sally Forth", author: sallyFoo)
		let sallyBook2 = Book(title: "Sally Fifth", author: sallyFoo)
		let anonymousBook = Book(title: "Anonymous", author: johnDoe)
		
		self.authors.append(timJones)
		self.authors.append(sallyFoo)
		self.authors.append(johnDoe)
		
		self.books.append(jonesBook)
		self.books.append(jonesBook2)
		self.books.append(sallyBook)
		self.books.append(sallyBook2)
		self.books.append(anonymousBook)
	}
	
	func findBook(title: String, authorFirst: String, authorLast: String) -> Book? {
		for book in books {
			if book.title == title &&
				book.author.firstName == authorFirst &&
				book.author.lastName == authorLast
			{
				return book
			}
		}
		return nil
	}
	
	func findAuthor(first: String, last: String) -> Author? {
		for author in authors {
			if author.firstName == first &&
				author.lastName == last
			{
				return author
			}
		}
		return nil
	}
}
#endif /* false */
