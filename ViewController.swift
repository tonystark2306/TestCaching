//
//  ViewController.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private var photos: [UnsplashPhoto] = []
    private let unsplashService = UnsplashService()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Danh sách ảnh"
        navigationItem.rightBarButtonItem = .init(image: UIImage.actions, style: .plain, target: self, action: #selector(reload))
        
        setupCollectionView()
        fetchPhotos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(">>>>>>>>>>>>>>> Sap het bo nho")
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "image_cell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width / 2, height: 320)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        collectionView.collectionViewLayout = layout
    }
    
    @objc private func reload() {
        fetchPhotos()
    }

    private func fetchPhotos() {
        unsplashService.fetchPhotos(isUseCache: false) { [weak self] photos, error in
            DispatchQueue.main.async {
                if let photos = photos {
                    self?.photos = photos
                    self?.collectionView.reloadData()
                }
            }
        }
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_cell", for: indexPath) as! ImageCell
        let photo = photos[indexPath.row]
        cell.configData(photo: photo)
        return cell
    }
}
