//
//  ImageCell.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

var cached: [UICollectionViewCell: Set<String>] = [:]

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
        cached[self, default: .init()].insert(photo.urls.regular)
        print(cached.filter({ $0.value.count > 1 }))
        ImageLoader.loadImage(from: photo.urls.regular, isUseCache: true) { [weak self] image in
            let image = image?.withTonalFilter
            DispatchQueue.main.async {
                self?.itemImageView.image = image
            }
        }
    }
}
