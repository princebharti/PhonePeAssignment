//
//  HomeTableViewCell.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func didTapAddToPlaylist()
}

class HomeTableViewCell: UITableViewCell, CellIdentifiable {
    
    weak var delegate: HomeTableViewCellDelegate?
    
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    private var viewModel: ChildHomeViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        artworkImageView.image = nil
        
    }
    
    private func resetUI() {
        artworkImageView.image = nil
        titleLbl.text = nil
        subTitleLbl.text = nil
        descriptionLbl.text = nil
    }
    
    
    func configureUI(viewModel: ChildHomeViewModel?){
        self.viewModel = viewModel
        titleLbl.text = viewModel?.title
        subTitleLbl.text = viewModel?.subtitle
        descriptionLbl.text = viewModel?.description
        if let artworkURL = viewModel?.artworkImageURL {
            artworkImageView.url = artworkURL
        }
    }

    @IBAction func starButtonTapped(_ sender: Any) {
        delegate?.didTapAddToPlaylist()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
}
