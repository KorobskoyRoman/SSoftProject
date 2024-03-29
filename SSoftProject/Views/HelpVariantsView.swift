//
//  HelpVariantsView.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 20.07.2022.
//

import Foundation
import UIKit

final class HelpVariantsView: UIView {
    private var shirtImage = UIImageView()
    private var handsImage = UIImageView()
    private var toolsImage = UIImageView()
    private var coinsImage = UIImageView()

    private var shirtBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.warmGrey, for: .normal)
        button.titleLabel?.font = .textStyle16
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = UIKitConstants.numberOfLines2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var handsBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.warmGrey, for: .normal)
        button.titleLabel?.font = .textStyle16
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = UIKitConstants.numberOfLines2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var toolsBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.warmGrey, for: .normal)
        button.titleLabel?.font = .textStyle16
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = UIKitConstants.numberOfLines2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private var coinsBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.warmGrey, for: .normal)
        button.titleLabel?.font = .textStyle16
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = UIKitConstants.numberOfLines2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var shirtStackView = UIStackView(arrangedSubviews: [shirtBtn],
                                                  axis: .vertical,
                                                  spacing: ConstraintsConst.inset9,
                                                  aligment: .center,
                                                  distribution: .equalCentering)

    private lazy var handsStackView = UIStackView(arrangedSubviews: [handsBtn],
                                                  axis: .vertical,
                                                  spacing: ConstraintsConst.inset7,
                                                  aligment: .center,
                                                  distribution: .fillProportionally)

    private lazy var toolsStackView = UIStackView(arrangedSubviews: [toolsBtn],
                                                  axis: .vertical,
                                                  spacing: ConstraintsConst.inset7,
                                                  aligment: .center,
                                                  distribution: .equalSpacing)

    private lazy var coinsStackView = UIStackView(arrangedSubviews: [coinsBtn],
                                                  axis: .vertical,
                                                  spacing: ConstraintsConst.inset4,
                                                  distribution: .equalCentering)
    private lazy var stackView = UIStackView(arrangedSubviews: [shirtStackView,
                                                                UIImageView(image:
                                                                                UIImage(named: Separator.separator1)),
                                                                handsStackView,
                                                                UIImageView(image:
                                                                                UIImage(named: Separator.separator1)),
                                                                toolsStackView,
                                                                UIImageView(image:
                                                                                UIImage(named: Separator.separator1)),
                                                                coinsStackView],
                                             axis: .horizontal,
                                             spacing: ConstraintsConst.inset13and5,
                                             aligment: .center,
                                             distribution: .equalCentering)

    private lazy var cats = [
        Category(title: .shirt, image: .shirt),
        Category(title: .hands, image: .hands),
        Category(title: .tools, image: .tools),
        Category(title: .coins, image: .coins)
    ]

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init() {
        super.init(frame: .zero)
        prepareView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareView() {
        backgroundColor = .offWhite
        shirtImage.contentMode = .scaleAspectFit
        handsImage.contentMode = .scaleAspectFit
        toolsImage.contentMode = .scaleAspectFit
        coinsImage.contentMode = .scaleAspectFit

        shirtImage.image = cats[0].image.image
        handsImage.image = cats[1].image.image
        toolsImage.image = cats[2].image.image
        coinsImage.image = cats[3].image.image

        shirtBtn.setTitle(cats[0].title.rawValue, for: .normal)
        shirtBtn.setImage(cats[0].image.image, for: .normal)
        shirtBtn.centerImageAndButton(ConstraintsConst.inset7, imageOnTop: true)

        handsBtn.setTitle(cats[1].title.rawValue, for: .normal)
        handsBtn.setImage(cats[1].image.image, for: .normal)
        handsBtn.centerImageAndButton(ConstraintsConst.inset7, imageOnTop: true)

        toolsBtn.setTitle(cats[2].title.rawValue, for: .normal)
        toolsBtn.setImage(cats[2].image.image, for: .normal)
        toolsBtn.centerImageAndButton(ConstraintsConst.inset7, imageOnTop: true)

        coinsBtn.setTitle(cats[3].title.rawValue, for: .normal)
        coinsBtn.setImage(cats[3].image.image, for: .normal)
        coinsBtn.centerImageAndButton(ConstraintsConst.inset7, imageOnTop: true)
    }

    private func setConstraints() {
        addSubview(stackView)
        addSubview(separatorView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            separatorView.topAnchor.constraint(equalTo: self.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

private enum Images: String {
    case shirt
    case hands
    case tools
    case coins

    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

private enum Titles: String {
    case shirt = "Помощь \nвещами"
    case hands = "Стать \nволонтером"
    case tools = "Проф. \nпомощь"
    case coins = "Помочь \nденьгами"
}

private struct Category {
    let title: Titles
    let image: Images
}

private enum Separator {
    static let separator1 = "separator1"
}
