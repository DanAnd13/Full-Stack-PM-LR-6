import Foundation

// Модель відповіді від YouTube API
struct YouTubeResponse: Decodable {
    let items: [YouTubeVideo]
}

// Модель відео
struct YouTubeVideo: Decodable, Identifiable {
    let id: String // Додана властивість id для відповідності протоколу Identifiable
    let snippet: Snippet
    let statistics: Statistics

    var title: String { snippet.title }
    var thumbnailURL: URL { URL(string: snippet.thumbnails.medium.url)! }
    var viewCount: String { statistics.viewCount }
    var videoURL: URL { // Додаємо властивість для URL відео
            URL(string: "https://www.youtube.com/watch?v=\(id)")!
        }

    enum CodingKeys: String, CodingKey {
        case id = "id" // Виправлено на "id", оскільки YouTube API повертає id у вигляді об'єкта
        case snippet, statistics
    }
}

// Допоміжні моделі
struct Snippet: Decodable {
    let title: String
    let thumbnails: Thumbnails
}

struct Thumbnails: Decodable {
    let medium: Thumbnail
}

struct Thumbnail: Decodable {
    let url: String
}

struct Statistics: Decodable {
    let viewCount: String
}
