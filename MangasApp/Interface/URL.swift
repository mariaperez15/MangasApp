//
//  URL.swift
//  MangasApp
//
//  Created by María Pérez  on 14/12/24.
//

import Foundation

let mainURL = URL(string: "https://mymanga-acacademy-5607149ebe3d.herokuapp.com")!

extension URL {
    //Endpoint Get all Mangas
    static func getAllMangas(page: String) -> URL {
        mainURL
            .appending(path: "list")
            .appending(path: "mangas")
            .appending(queryItems: [.pageQuery(page: page)])
    }
    
    //Endpoint Search Manga Contains
    static func searchMangaContains(name: String) -> URL {
        mainURL
            .appending(path: "search")
            .appending(path: "mangasContains")
            .appending(path: name)
    }
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
}
