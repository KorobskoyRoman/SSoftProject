//
//  CharityCell.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

import UIKit

final class CharityCell: UICollectionViewCell {
    static let reuseId = "CharityCell"

    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = .blueGrey
        title.font = .textStyle
        title.textAlignment = .center
        title.numberOfLines = .zero
        return title
    }()
    private var details: UILabel = {
        let details = UILabel()
        details.textColor = .darkSlateBlue
        details.font = .textStyle7
        details.textAlignment = .center
        details.numberOfLines = .zero
        return details
    }()
    private var date: UILabel = {
        let date = UILabel()
        date.textAlignment = .center
        date.textColor = .white
        date.font = .systemFont(ofSize: 11)
        return date
    }()
    private var separateImage = UIImageView(image: UIImage(named: "separator"))
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .leaf
        return view
    }()
    private var bottomImage = UIImageView(image: UIImage(named: "calendar"))
    private var blurImage = UIImageView(image: UIImage(named: "blur"))
    private lazy var botStackView = UIStackView(arrangedSubviews: [bottomImage, date],
                                                axis: .horizontal,
                                                spacing: Constraints.inset)

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = Constraints.cornerRadius
        self.clipsToBounds = true
        self.image.clipsToBounds = true
        self.image.layer.cornerRadius = Constraints.cornerRadius
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: RealmEvent) {
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

    static let cornerRadius: CGFloat = 10

    static let cornerMultiply: CGFloat = 10
    static let shadowRadius: CGFloat = 3
    static let shadowOpacity: Float = 0.5
    static let shadowOffsetHeight = 4
}

private enum ImagesCharityCell {
    static let separateImage = UIImageView(image: UIImage(named: "separator"))
    static let bottomImage = UIImageView(image: UIImage(named: "calendar"))
    static let blurImage = UIImageView(image: UIImage(named: "blur"))
}
