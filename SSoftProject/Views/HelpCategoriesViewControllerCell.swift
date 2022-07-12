//
//  HelpCategoriesCell.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

import UIKit

class HelpCategoriesCell: UICollectionViewCell {
    static let reuseId = "HelpCategoriesCell"
    
    private var image = UIImageView()
    private var title = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.image.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGreyTwo
        title.textColor = .lightOliveGreen
        title.font = .textStyle13
        setConstraints()
        
        self.image.contentMode = .scaleAspectFit
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Categories) {
        image.image = UIImage(named: model.image)
        title.text = model.title
    }
    
    private func setConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(image)
        addSubview(title)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 37),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -37),
            image.widthAnchor.constraint(equalToConstant: 94),
            image.heightAnchor.constraint(equalToConstant: 63),
            
            title.topAnchor.constraint(lessThanOrEqualTo: image.bottomAnchor, constant: 38),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            title.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: 72),
//            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -71),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            title.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
