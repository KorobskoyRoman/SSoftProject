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
        self.layer.cornerRadius = self.frame.height / Constraints.cornerMultiply
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
        self.layer.shadowRadius = Constraints.shadowRadius
        self.layer.shadowOpacity = Constraints.shadowOpacity
        self.layer.shadowOffset = CGSize(width: .zero, height: Constraints.shadowOffsetHeight)
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
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: Constraints.imageTopBot),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constraints.imageLeading),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constraints.imageTopBot),
            image.heightAnchor.constraint(equalToConstant: Constraints.imageHeight),

            title.topAnchor.constraint(lessThanOrEqualTo: image.bottomAnchor, constant: Constraints.titleTop),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constraints.titleBot),
            title.heightAnchor.constraint(equalToConstant: Constraints.titleHeight)
        ])
    }
}

private enum Constraints {
    static let imageTopBot: CGFloat = 37
    static let imageLeading: CGFloat = 43
    static let imageWidth: CGFloat = 94
    static let imageHeight: CGFloat = 63

    static let titleTop: CGFloat = 38
    static let titleLeadTrail: CGFloat = 71
    static let titleBot: CGFloat = 10
    static let titleHeight: CGFloat = 18

    static let cornerMultiply: CGFloat = 10
    static let shadowRadius: CGFloat = 3
    static let shadowOpacity: Float = 0.5
    static let shadowOffsetHeight = 4
}
