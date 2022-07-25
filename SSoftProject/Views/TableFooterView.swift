//
//  TableFooterView.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 20.07.2022.
//

import UIKit

final class TableFooterView: UIView {
    private var images: [UIImageView]
    private var image1 = UIImageView()
    private var image2 = UIImageView()
    private var image3 = UIImageView()
    private var image4 = UIImageView()
    private var image5 = UIImageView()

    private var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grey
        label.font = .textStyle11
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var imageStackView = UIStackView(arrangedSubviews: [],
                                                  axis: .horizontal,
                                                  spacing: -ConstraintsConst.inset10,
                                                  distribution: .equalCentering)
    private var imagesArr = [UIImageView]()

    init(images: [UIImageView]) {
        self.images = images
        super.init(frame: .zero)
        self.layoutIfNeeded()
        backgroundColor = .lightGrey
        imagesArr = [image1, image2, image3, image4, image5]
        self.prepareView()
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutIfNeeded()
        imagesArr.forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
        super.layoutSubviews()
    }

    private func prepareView() {
        countLabel.text = images.count > imagesArr.count ? "+\(images.count - imagesArr.count)" : ""
        imagesArr.forEach {
            let view = createImageView(from: $0)
            let currentIndex = imagesArr.firstIndex(of: $0) ?? 0
            guard currentIndex <= images.count-1 else { return }
            view.image = images[currentIndex].image
            view.layer.cornerRadius = view.frame.height / 2
            imageStackView.addArrangedSubview(view)
        }
    }

    private func createImageView(from imageView: UIImageView) -> UIImageView {
        imageView.layer.borderColor = UIColor.lightGrey.cgColor
        imageView.layer.borderWidth = 3.0
        imageView.layer.masksToBounds = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: ConstraintsConst.inset36).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: ConstraintsConst.inset36).isActive = true
        return imageView
    }

    private func setConstraints() {
        addSubview(imageStackView)
        addSubview(countLabel)

        NSLayoutConstraint.activate([
            imageStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                    constant: ConstraintsConst.inset20),
            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: imageStackView.trailingAnchor,
                                                constant: ConstraintsConst.inset10)
        ])
    }
}
