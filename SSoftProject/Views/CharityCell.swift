//
//  CharityCell.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

import UIKit

class CharityCell: UICollectionViewCell {
    static let reuseId = "CharityCell"

    private var image = UIImageView()
    private var title = UILabel()
    private var details = UILabel()
    private var date = UILabel()
    private var separateImage = UIImageView(image: UIImage(named: "separator"))
    private let bottomView = UIView()
    private var bottomImage = UIImageView(image: UIImage(named: "calendar"))
    private var blurImage = UIImageView(image: UIImage(named: "blur"))
    private lazy var botStackView = UIStackView(arrangedSubviews: [bottomImage, date])

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.image.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        image.contentMode = .scaleAspectFill

        backgroundColor = .white
        title.textColor = .blueGrey
        title.font = .textStyle
        title.textAlignment = .center
        title.numberOfLines = .zero

        details.textColor = .darkSlateBlue
        details.font = .textStyle7
        details.textAlignment = .center
        details.numberOfLines = .zero

//        var rect: CGRect = date.frame
//        rect.size = date.text?.size(withAttributes: [NSAttributedString.Key.font:
//                                                        UIFont(name: date.font.fontName,
//                                                               size: date.font.pointSize)
//                                                     ?? CGSize(width: 0, height: 0)])
//                    ?? CGSize(width: 0, height: 0)
//        date.widthAnchor.constraint(equalToConstant: rect.width).isActive = true
        date.textAlignment = .center
        date.textColor = .white
        date.font = .systemFont(ofSize: 11)

        bottomView.backgroundColor = .leaf

        botStackView.axis = .horizontal
        botStackView.contentMode = .scaleAspectFill
        botStackView.spacing = Constraints.inset

        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: Event) {
        image.image = UIImage(named: model.image)
        title.text = model.title
        details.text = model.details
        date.text = model.date
    }

    private func setupView() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        details.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false
        separateImage.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomImage.translatesAutoresizingMaskIntoConstraints = false
        blurImage.translatesAutoresizingMaskIntoConstraints = false
        botStackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(image)
        image.addSubview(blurImage)
        addSubview(title)
        addSubview(separateImage)
        addSubview(details)
        addSubview(bottomView)
        bottomView.addSubview(botStackView)
    }

    private func setConstraints() {
        setupView()

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: Constraints.imageTopBot),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: Constraints.imageLeading),
            image.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -Constraints.imageTopBot),
            image.heightAnchor.constraint(equalToConstant: Constraints.imageHeight),

            blurImage.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            blurImage.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            blurImage.bottomAnchor.constraint(equalTo: image.bottomAnchor),

            title.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -Constraints.titleTop),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: Constraints.titleLeadTrail),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -Constraints.titleLeadTrail),
            title.heightAnchor.constraint(equalToConstant: Constraints.titleHeight),

            separateImage.topAnchor.constraint(equalTo: title.bottomAnchor,
                                               constant: Constraints.separateImageTopBotInset),
            separateImage.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: Constraints.separateImageEdgeInset),
            separateImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                   constant: -Constraints.separateImageEdgeInset),
            separateImage.heightAnchor.constraint(equalToConstant: Constraints.separateImageHeight),

            details.topAnchor.constraint(equalTo: separateImage.bottomAnchor,
                                         constant: Constraints.separateImageTopBotInset),
            details.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: Constraints.detailsEdgeInset),
            details.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                             constant: -Constraints.detailsEdgeInset),
            details.heightAnchor.constraint(equalToConstant: Constraints.detailsHeight),

            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: Constraints.bottomViewHeight),

            botStackView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            botStackView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor)
        ])
    }
}

private enum Constraints {
    static let imageTopBot: CGFloat = 4
    static let imageLeading: CGFloat = 4
    static let imageHeight: CGFloat = 231

    static let titleTop: CGFloat = 15
    static let titleLeadTrail: CGFloat = 46
    static let titleBot: CGFloat = 10
    static let titleHeight: CGFloat = 46

    static let separateImageTopBotInset: CGFloat = 8
    static let separateImageEdgeInset: CGFloat = 123
    static let separateImageHeight: CGFloat = 20

    static let detailsEdgeInset: CGFloat = 23
    static let detailsHeight: CGFloat = 60

    static let bottomViewHeight: CGFloat = 31

    static let dateHeight: CGFloat = 13

    static let inset: CGFloat = 10

    static let cornerMultiply: CGFloat = 10
    static let shadowRadius: CGFloat = 3
    static let shadowOpacity: Float = 0.5
    static let shadowOffsetHeight = 4
}
