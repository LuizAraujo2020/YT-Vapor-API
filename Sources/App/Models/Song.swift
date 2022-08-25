//
//  Song.swift
//  
//
//  Created by Luiz Araujo on 25/08/22.
//

import Fluent
import Vapor

/// This is how we are going to query the class.
/// Represents the data inside the Database.
final class Song: Model, Content {
    /// Representation of the Table to be used.
    static let schema = "songs"
    
    /// "Wrappers" to help Fluent to reckgonize everything that is in the table.
    /// Helps match the columns in the Database.
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() { }
    
    init(id: UUID?, title: String) throws {
        self.id = id
        self.title = title
    }
}


