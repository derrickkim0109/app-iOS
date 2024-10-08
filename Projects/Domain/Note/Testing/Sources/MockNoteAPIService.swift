//
//  MockNoteAPIService.swift
//  DomainNote
//
//  Created by 황인우 on 8/18/24.
//

import Combine
import Foundation

import Core
import DomainNoteInterface
import DomainSharedInterface

public struct MockNoteAPIService: NoteAPIServiceInterface {
    private let scenario: DomainTestScenario<NoteError>
    
    public init(scenario: DomainTestScenario<NoteError>) {
        self.scenario = scenario
    }
    
    public func getFavoriteArtistsRelatedNotes(
        currentPage: Int?,
        numberOfNotes: Int,
        hasLyrics: Bool
    ) -> AnyPublisher<GetNotesResponse, NoteError> {
        switch scenario {
        case .success:
            let seedJsonData = DomainSeed.getNoteResponseJsonData
            let expectedModel = try! JSONDecoder().decode(GetNotesResponse.self, from: seedJsonData)
            
            return Just(expectedModel)
                .setFailureType(to: NoteError.self)
                .eraseToAnyPublisher()
            
        case .failure(let noteError):
            return Fail(error: noteError)
                .eraseToAnyPublisher()
        }
    }
    
    public func postLike(noteID: Int) -> AnyPublisher<NoteLikeResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteLike(noteID: Int) -> AnyPublisher<NoteLikeResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func postBookmark(noteID: Int) -> AnyPublisher<BookmarkResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteBookmark(noteID: Int) -> AnyPublisher<BookmarkResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func postNote(value: PostNoteValue) -> AnyPublisher<FeelinSuccessResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func searchSong(keyword: String, currentPage: Int, numberOfSongs: Int, artistID: Int) -> AnyPublisher<SearchSongResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func deleteNote(noteID: Int) -> AnyPublisher<NoteChangeResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func getSongNotes(
        currentPage: Int?,
        numberOfNotes: Int,
        hasLyrics: Bool,
        songID: Int
    ) -> AnyPublisher<GetNotesResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
    
    public func getSearchedNotes(pageNumber: Int, pageSize: Int, query: String) -> AnyPublisher<SearchedNotesResponse, NoteError> {
        return Empty()
            .setFailureType(to: NoteError.self)
            .eraseToAnyPublisher()
    }
}
