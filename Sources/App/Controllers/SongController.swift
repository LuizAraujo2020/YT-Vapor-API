//
//  SongController.swift
//  
//
//  Created by Luiz Araujo on 25/08/22.
//

import Fluent
import Vapor

/// Collection of differents Routes and Functionalities.
struct SongController: RouteCollection  {
    /// The first function that runs.
    func boot(routes: RoutesBuilder) throws {
        /// When we go to root route(http://127.0.0.1:8080/songs) gets grouped here.
        let songs = routes.grouped("songs")
        songs.get(use: index)
        songs.post(use: create)
        songs.put(use: update)
        songs.group(":songID") { song in
            song.delete(use: delete)
        }
    }
    
    /// Route: .../songs
    /// GET Request - retrieves data
    /// EventLoopFuture is all about future and promises, it's about Asynchronous code.
    func index(req: Request) throws -> EventLoopFuture<[Song]> {
        return Song.query(on: req.db).all()
    }
    
    /// POST Request - gets the request from Postman/iOS App and create a new entry in the DB.
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        /// Decode the contento to a type Song, it's like JSON decoding.
        let song = try req.content.decode(Song.self)
        return song.save(on: req.db).transform(to: .ok)
    }
    
    
    /// PUT Request - /songs
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try req.content.decode(Song.self)
        
        return Song.find(song.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = song.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    /// DELETE Request - /songs/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Song.find(req.parameters.get("songID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
