//
//  ContentView.swift
//  Danulov_LR-6
//
//  Created by Student on 06.12.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = YouTubeViewModel()

    var body: some View {
        NavigationView {
            if viewModel.videos.isEmpty {
                ProgressView("Завантаження...")
                    .onAppear {
                        viewModel.fetchPopularVideos()
                    }
            } else {
                List(viewModel.videos) { video in
                    VideoRow(video: video)
                }
                .navigationTitle("Популярні відео")
            }
        }
    }
}

struct VideoRow: View {
    let video: YouTubeVideo

    var body: some View {
        HStack {
            AsyncImage(url: video.thumbnailURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 60)

            VStack(alignment: .leading, spacing: 5) {
                Text(video.title)
                    .font(.headline)
                    .lineLimit(2)
                Text("\(video.viewCount) переглядів")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onTapGesture {
            openVideo(video.videoURL) // Використовуємо URL для відео
        }
    }

    private func openVideo(_ url: URL) {
        UIApplication.shared.open(url)
    }
}
