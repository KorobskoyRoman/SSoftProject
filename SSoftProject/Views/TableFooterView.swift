//
//  TableFooterView.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 20.07.2022.
//

import UIKit

class TableFooterView: UIView {
    private var images: [UIImage]

    private lazy var image1 = createImageView()
    private lazy var image2 = createImageView()
    private lazy var image3 = createImageView()
    private lazy var image4 = createImageView()
    private lazy var image5 = createImageView()
    private var countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grey
        label.font = .textStyle11
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

//    private lazy var imageStackView = UIStackView(arrangedSubviews: [
//        image1,
//        image2,
//        image3,
//        image4,
//        image5
//    ],
//                                                  axis: .horizontal,
//                                                  spacing: -1,
//                                                  distribution: .fillEqually)
    private var imagesArr = [UIImageView]()

    init(images: [UIImage]) {
        self.images = images
        super.init(frame: .zero)
        backgroundColor = .lightGrey
        imagesArr = [image1, image2, image3, image4, image5]
        self.prepareView()
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imagesArr.forEach {
            $0.layer.cornerRadius = $0.frame.height / 2
        }
    }

    private func prepareView() {
        countLabel.text = "+ \(images.count - imagesArr.count)"
        imagesArr.forEach { $0.image = images[0] }
    }

    private func createImageView() -> UIImageView {
        let imageView = UIImageView()
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
//        addSubview(imageStackView) // через стэк не округлялись, пришлось сделать отдельно, если ок - удалю комменты
        addSubview(countLabel)
        addSubview(image1)
        insertSubview(image2, belowSubview: image1)
        insertSubview(image3, belowSubview: image2)
        insertSubview(image4, belowSubview: image3)
        insertSubview(image5, belowSubview: image4)

        NSLayoutConstraint.activate([
            image1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image1.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                            constant: ConstraintsConst.inset20),
            image2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image2.leadingAnchor.constraint(equalTo: image1.trailingAnchor,
                                            constant: -ConstraintsConst.inset5),
            image3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image3.leadingAnchor.constraint(equalTo: image2.trailingAnchor,
                                            constant: -ConstraintsConst.inset5),
            image4.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image4.leadingAnchor.constraint(equalTo: image3.trailingAnchor,
                                            constant: -ConstraintsConst.inset5),
            image5.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image5.leadingAnchor.constraint(equalTo: image4.trailingAnchor,
                                            constant: -ConstraintsConst.inset5),

            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: image5.trailingAnchor,
                                                constant: ConstraintsConst.inset10)
        ])
    }
}
