//
//  DetailEventCell.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 19.07.2022.
//

import UIKit

final class DetailEventCell: UITableViewCell {
    static let reuseId = "DetailEventCell"

    private var title: UILabel = {
        let label = UILabel()
        label.font = .textStyle8
        label.textColor = .blueGrey
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var calendarImg = ImagesDetailEventCell.calendarImg
    private var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11)
        label.textColor = .grey
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var dateStackView = UIStackView(arrangedSubviews: [calendarImg, dateLabel],
                                                 axis: .horizontal,
                                                 spacing: ConstraintsConst.inset10)

    private var navIcon: UIImageView = {
        let navIcon = UIImageView()
        navIcon.contentMode = .scaleAspectFit
        navIcon.image = ImagesDetailEventCell.navIcon
        return navIcon
    }()
    private var address: UILabel = {
        let label = UILabel()
        label.font = .textStyle4
        label.textColor = .charcoalGrey
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var addressStackView = UIStackView(arrangedSubviews: [navIcon, address],
                                                    axis: .horizontal,
                                                    spacing: ConstraintsConst.inset10,
                                                    distribution: .fillProportionally)

    private var iconPhone: UIImageView = {
        let iconPhone = UIImageView()
        iconPhone.contentMode = .scaleAspectFit
        iconPhone.image = ImagesDetailEventCell.iconPhone
        return iconPhone
    }()
    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .textStyle4
        label.textColor = .charcoalGrey
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var phoneStackView = UIStackView(arrangedSubviews: [iconPhone, phoneLabel],
                                                    axis: .horizontal,
                                                    spacing: ConstraintsConst.inset8,
                                                  distribution: .fillProportionally)

    private lazy var phoneAddressStackView = UIStackView(arrangedSubviews: [addressStackView, phoneStackView],
                                                         axis: .vertical,
                                                         spacing: ConstraintsConst.inset16)

    private var iconMail: UIImageView = {
        let iconMail = UIImageView()
        iconMail.contentMode = .scaleAspectFit
        iconMail.image = ImagesDetailEventCell.iconMail
        return iconMail
    }()
    private var mailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.mailLabelTitle
        label.font = .textStyle4
        label.textColor = .charcoalGrey
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var mailButton: UIButton = {
        let button = UIButton(type: .system)
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.textStyle5,
            .foregroundColor: UIColor.leaf,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: Constants.mainButtonTitle,
            attributes: yourAttributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(DetailEventViewController().self, action: #selector(mailButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private lazy var mailStackView = UIStackView(arrangedSubviews: [iconMail, mailLabel, mailButton],
                                                 axis: .horizontal,
                                                 spacing: ConstraintsConst.inset8,
                                                 distribution: .fill)

    private var details2Label: UILabel = {
        let label = UILabel()
        label.font = .textStyle4
        label.textColor = .charcoalGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var details3Label: UILabel = {
        let label = UILabel()
        label.font = .textStyle4
        label.textColor = .charcoalGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var detailsStackView = UIStackView(arrangedSubviews: [details2Label, details3Label],
                                                    axis: .vertical,
                                                    spacing: ConstraintsConst.inset10)

    private var bigImage: UIImageView = {
        let bigImage = UIImageView()
        bigImage.contentMode = .scaleAspectFit
        return bigImage
    }()
    private var topMiniImage: UIImageView = {
        let topMiniImage = UIImageView()
        topMiniImage.contentMode = .scaleAspectFill
        return topMiniImage
    }()
    private var botMiniImage: UIImageView = {
        let botMiniImage = UIImageView()
        botMiniImage.contentMode = .scaleAspectFill
        return botMiniImage
    }()
    private lazy var miniPhotosStackView = UIStackView(arrangedSubviews: [topMiniImage, botMiniImage],
                                                       axis: .vertical,
                                                       spacing: ConstraintsConst.inset10,
                                                       distribution: .fillProportionally)
    private lazy var photosStackView = UIStackView(arrangedSubviews: [bigImage, miniPhotosStackView],
                                                   axis: .horizontal,
                                                   spacing: ConstraintsConst.inset10,
                                                   distribution: .fillProportionally)

    private var organizationButton: UIButton = {
        let button = UIButton(type: .system)
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.textStyle5,
            .foregroundColor: UIColor.leaf,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSMutableAttributedString(
            string: Constants.ogranizationButtonTitle,
            attributes: yourAttributes
        )
        button.setAttributedTitle(attributeString, for: .normal)
        button.addTarget(DetailEventViewController().self,
                         action: #selector(organizationButtonTapped),
                         for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        bigImage.clipsToBounds = true
        topMiniImage.clipsToBounds = true
        botMiniImage.clipsToBounds = true

        bigImage.layer.masksToBounds = true
        topMiniImage.layer.masksToBounds = true
        botMiniImage.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(from model: RealmEvent) {
        title.text = model.title
        dateLabel.text = model.date
        address.text = model.address
        phoneLabel.text = model.phone
        bigImage.image = UIImage(named: model.image)
        topMiniImage.image = UIImage(named: model.image)
        botMiniImage.image = UIImage(named: model.image)
        details2Label.text = model.details2
        details3Label.text = model.details3
    }

    private func setupViews() {
        navIcon.contentMode = .scaleAspectFit
        iconPhone.contentMode = .scaleAspectFit
        iconMail.contentMode = .scaleAspectFit

        bigImage.contentMode = .scaleAspectFit
        topMiniImage.contentMode = .scaleAspectFill
        botMiniImage.contentMode = .scaleAspectFill
    }

    private func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(dateStackView)
        contentView.addSubview(phoneAddressStackView)
        contentView.addSubview(mailStackView)
        contentView.addSubview(photosStackView)
        contentView.addSubview(detailsStackView)
        contentView.addSubview(organizationButton)
    }

    @objc private func mailButtonTapped() {
        print("mailButtonTapped")
    }

    @objc private func organizationButtonTapped() {
        print("organizationButtonTapped")
    }
}

extension DetailEventCell {
    private func setConstraints() {
        setupSubviews()
        miniPhotosStackView.widthAnchor.constraint(equalToConstant: Constants.miniPhotosStackViewWidth)
            .isActive = true

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: ConstraintsConst.inset20),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: ConstraintsConst.inset20),
            title.widthAnchor.constraint(equalToConstant: Constants.titleWidth),

            dateStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: ConstraintsConst.inset17),
            dateStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: ConstraintsConst.inset20),

            phoneAddressStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor,
                                                        constant: ConstraintsConst.inset15),
            phoneAddressStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                           constant: ConstraintsConst.inset20),
            phoneAddressStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                            constant: -ConstraintsConst.inset33),

            mailStackView.topAnchor.constraint(equalTo: phoneAddressStackView.bottomAnchor,
                                               constant: ConstraintsConst.inset16),
            mailStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                           constant: ConstraintsConst.inset20),
            mailStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor,
                                                            constant: -ConstraintsConst.inset33*2),

            photosStackView.topAnchor.constraint(equalTo: mailStackView.bottomAnchor,
                                                 constant: ConstraintsConst.inset16),
            photosStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                           constant: ConstraintsConst.inset20),
            photosStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor,
                                                            constant: -ConstraintsConst.inset20),
            photosStackView.heightAnchor.constraint(equalToConstant: Constants.photosStackViewHeight),

            detailsStackView.topAnchor.constraint(equalTo: photosStackView.bottomAnchor,
                                                  constant: ConstraintsConst.inset10),
            detailsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                           constant: ConstraintsConst.inset20),
            detailsStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor,
                                                            constant: -ConstraintsConst.inset20),

            organizationButton.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor,
                                                    constant: ConstraintsConst.inset16),
            organizationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                        constant: ConstraintsConst.inset20)
        ])
    }
}

private enum Constants {
    static let mailLabelTitle = "У вас есть вопросы?"
    static let mainButtonTitle = "Напишите нам"
    static let ogranizationButtonTitle = "Перейти на сайт организаии"

    static let miniPhotosStackViewWidth: CGFloat = 103
    static let titleWidth: CGFloat = 267
    static let photosStackViewHeight: CGFloat = 168
}

private enum ImagesDetailEventCell {
    static let calendarImg = UIImageView(image: UIImage(named: "iconCal"))
    static let navIcon = UIImage(named: "iconNav")
    static let iconPhone = UIImage(named: "iconPhone")
    static let iconMail = UIImage(named: "mail")
}
