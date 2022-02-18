//
//  Post.swift
//  PDP_StoryboardContact
//

import Foundation

struct Contact: Decodable {
    var id: String? = ""
    var title: String? = ""
    var body: String? = ""
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
