import Foundation
import Combine

class YouTubeViewModel: ObservableObject {
    @Published var videos: [YouTubeVideo] = []

    private let apiKey = "AIzaSyB57pZfanh_tRZBVhCObqu8e8Cu6t63Y0I" // Замініть на свій API ключ
    private var cancellables = Set<AnyCancellable>()

    func fetchPopularVideos() {
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&chart=mostPopular&regionCode=US&maxResults=10&key=\(apiKey)") else {
            print("Неправильний URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: YouTubeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        print("Помилка отримання даних: \(error)")
                    }
                },
                receiveValue: { [weak self] response in
                    self?.videos = response.items
                }
            )
            .store(in: &cancellables)
    }
}
