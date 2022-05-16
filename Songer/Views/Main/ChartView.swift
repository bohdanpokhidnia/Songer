//
//  ChartView.swift
//  Songer
//
//  Created by Bogdan Pohidnya on 24.11.2020.
//  Copyright © 2020 Bogdan Pohidnya. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    @State var chart: [TrackChart]
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(chart) { track in
                    SongCell(
                        isAddButtonShow: false,
                        number: (chart.firstIndex(where: { $0.uiid == track.uiid }) ?? 0) + 1,
                        urlImage: track.artworkUrl100,
                        songName: track.name,
                        author: track.artistName,
                        trackPreviewUrl: track.url
                    )
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            ItunesDataFetcher().fetchChart { chart in
                guard let chart = chart else { return }
                
                self.chart = chart
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chart: [.mockTrack])
    }
}
