//
//  ImageCache.swift
//  TestCaching
//
//  Created by Tran Dat on 26/2/25.
//

import UIKit

class ImageCache {
    static let shared = ImageCache() // Singleton instance
    private let cache = NSCache<NSString, UIImage>()

    private init() {
        // Cấu hình cache
        cache.countLimit = 100 // Giới hạn số lượng ảnh trong cache
        cache.totalCostLimit = 50 * 1024 * 1024 // Giới hạn tổng dung lượng cache (50 MB)
//        cache.totalCostLimit = -1
    }

    // Thêm ảnh vào cache
    func setImage(_ image: UIImage, forKey key: String) {
        let cost = image.size.width * image.size.height // Tính "cost" dựa trên kích thước ảnh
        cache.setObject(image, forKey: key as NSString, cost: Int(cost))
    }

    // Lấy ảnh từ cache
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    // Xóa ảnh khỏi cache
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    // Xóa toàn bộ cache
    func clearCache() {
        cache.removeAllObjects()
    }
}
