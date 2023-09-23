//
//  ChildHomeViewModel.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import Foundation


class ChildHomeViewModel {
    
    var artworkImageURL: String?
    var title: String?
    var subtitle: String?
    var description: String?
    var cellType: HomeViewCellType = .unknown
    
    init(with model: Movie) {
        if let artworkImageURL = model.posterPath  {
            self.artworkImageURL = "https://image.tmdb.org/t/p/w500" + artworkImageURL
        }
        title = model.originalTitle
        subtitle = "\(model.voteAverage ?? 0)"
        description = ""
    }
}
