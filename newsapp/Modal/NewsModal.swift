// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? newJSONDecoder().decode(News.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseNews { response in
//     if let news = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - News
struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseArticle { response in
//     if let article = response.result.value {
//       ...
//     }
//   }

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author, title, articleDescription: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseSource { response in
//     if let source = response.result.value {
//       ...
//     }
//   }

// MARK: - Source
struct Source: Codable {
    let id: ID
    let name: Name
}

enum ID: String, Codable {
    case techcrunch = "techcrunch"
}

enum Name: String, Codable {
    case techCrunch = "TechCrunch"
}

