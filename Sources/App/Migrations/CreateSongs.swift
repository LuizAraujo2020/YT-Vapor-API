//
//  CreateSongs.swift
//  
//
//  Created by Luiz Araujo on 25/08/22.
//

import Fluent

/// Tracks the changes
struct CreateSongs: Migration {
    /// The changes we wanna make.
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        /// Create table
        return database.schema("songs")
            /// Columns
            .id()
            .field("title", .string, .required)
            /// Create this table
            .create()
    }
    /// What we need to do to revert the changes made.
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("songs").delete()
    }
}


























