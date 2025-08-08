//
//  ImageCell.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = nil
    }

    func configData(photo: UnsplashPhoto) {
        ImageLoader.loadImage(from: photo.urls.regular, isUseCache: true) { [weak self] image in
            let image = image?.withTonalFilter
            DispatchQueue.main.async {
                self?.itemImageView.image = image
            }
        }
    }
}
