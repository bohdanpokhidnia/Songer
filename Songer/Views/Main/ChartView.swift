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
                ForEach(chart, id: \.uiid) { track in
                    SongCell(isAddButtonShow: false,
                             urlImage: track.artworkUrl100,
                             songName: track.name,
                             author: track.artistName,
                             trackPreviewUrl: track.url)
                }
                
            }
            .padding(.horizontal)
        }
        .onAppear {
            ItunesDataFetcher().fetchChart { chart in
                guard let chart = chart else { return }
                
                withAnimation(.spring()) {
                    self.chart = chart
                }
            }
        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chart: [])
    }
}
