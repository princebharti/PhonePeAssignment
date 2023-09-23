//
//  HomeViewModel.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import Foundation

enum HomeViewCellType {
    case detail
    case unknown
}


class HomeViewModel {
    
    weak var delegate: ViewModelDelegate?
    var items: [ChildHomeViewModel] = []
    
    func fetchDataAndUpdate() {
        let endPoint = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        DataManager.loadData(forEndPoint: endPoint) { [weak self] (model:HomeMetaModel?, error:Error?) in
            if let model = model {
                self?.prepareViewModelAndUpdate(model: model)
            } else {
                let error = error ?? NSError(domain: "UnknowError", code: 9005)
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.viewModelDidFail(identifier: nil, error: error)
                }
            }
        }
    }
    
    private func prepareViewModelAndUpdate(model: HomeMetaModel) {
        if let movies = model.movies {
            items = movies.map( {
                let vm = ChildHomeViewModel(with: $0)
                vm.cellType = .detail
                return vm
            } )
        }
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.viewModelDidUpdate(identifier: nil, data: nil)
        }
    }
}

