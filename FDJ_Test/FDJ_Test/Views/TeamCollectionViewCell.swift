//
//  TeamCollectionViewCell.swift
//  FDJ_Test
//
//  Created by Yannis VERBECQUE on 12/02/2021.
//

import Foundation
import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
        let imgview = UIImageView(frame: .zero)
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(self.imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
