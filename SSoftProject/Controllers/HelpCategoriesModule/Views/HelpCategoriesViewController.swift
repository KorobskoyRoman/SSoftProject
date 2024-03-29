//
//  HelpCategoriesViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class HelpCategoriesViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, RealmCategories>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RealmCategories>

    private lazy var collectionView = UICollectionView(frame: view.bounds,
                                                       collectionViewLayout: createCompositialLayout())
    private lazy var dataSource = createDiffableDataSource()
    private lazy var backButton: UIBarButtonItem = {
        return UIBarButtonItem(image: ImageConstants.backImage,
                               style: .plain,
                               target: self,
                               action: #selector(backButtonTapped))
    }()

    private lazy var titleLabel: UILabel = { // для фикса высоты тайтла
        let label = UILabel()
        label.text = HelpConstants.title
        label.textAlignment = .center
        label.tintColor = .white
        label.font = .textStyle3
        label.textColor = .white
        label.heightAnchor
            .constraint(equalToConstant: self.navigationController?.navigationBar.frame.height
                        ?? HelpConstants.Constraints.defaultNavBarHeight)
            .isActive = true
        return label
    }()
    private var viewModel: HelpCategoriesViewModel
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }

    init(viewModel: HelpCategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        reload()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func reload() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.applySnapshot()
        }
    }

    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        view.addSubview(collectionView)

        collectionView.register(HelpCategoriesCell.self, forCellWithReuseIdentifier: HelpCategoriesCell.reuseId)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
    }

    private func setupView() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        view.backgroundColor = .mainBackground()
        setupNavBar()
        setupCollectionView()
    }

    private func setupNavBar() {
        navigationController?.navigationBar.standardAppearance = configureNavBarAppearence()
        navigationController?.navigationBar.compactAppearance = configureNavBarAppearence()
        navigationController?.navigationBar.scrollEdgeAppearance = configureNavBarAppearence()
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.titleView = titleLabel
    }

    private func configureNavBarAppearence() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .leaf
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.textStyle3]

        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]

        appearance.backButtonAppearance = backButtonAppearance
        UINavigationBar.appearance().tintColor = .white

        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        return appearance
    }

    @objc private func backButtonTapped() {
        exit(0)
    }
}

// MARK: - Rx
extension HelpCategoriesViewController {
    private func bind() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        viewModel.categories
            .observe(on: MainScheduler.instance)
            .bind(to: collectionView.rx.items) { [weak self] collectionView, row, category in
                guard let self = self else { return UICollectionViewCell() }
                guard let cell = self.collectionView.dequeueReusableCell(
                    withReuseIdentifier: HelpCategoriesCell.reuseId,
                    for: IndexPath(row: row, section: 0)
                ) as? HelpCategoriesCell else { return UICollectionViewCell() }
                cell.configure(with: category)
                return cell
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Create layout
extension HelpCategoriesViewController {
    private func createCompositialLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Section not found")
            }
            switch section {
            case .mainSection:
                return self.createMainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = HelpConstants.Constraints.interSectionSpacing
        layout.configuration = config
        return layout
    }

    private func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(HelpConstants.Constraints.cellWidth),
                                              heightDimension: .absolute(HelpConstants.Constraints.cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(
            top: HelpConstants.Constraints.topItemInset,
            leading: HelpConstants.Constraints.itemInset,
            bottom: HelpConstants.Constraints.itemInset,
            trailing: HelpConstants.Constraints.itemInset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: HelpConstants.Constraints.groupSize)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = HelpConstants.Constraints.interGroupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: HelpConstants.Constraints.topItemInset,
            leading: HelpConstants.Constraints.itemInset,
            bottom: .zero,
            trailing: HelpConstants.Constraints.itemInset)

        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }

    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5),
                                                       heightDimension: .fractionalHeight(0.05))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                        elementKind:
                                                                            UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)

        return sectionHeader
    }
}

// MARK: - Create data source
extension HelpCategoriesViewController {
    private func createDiffableDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, image in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("No section")
            }
            switch section {
            case .mainSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCategoriesCell.reuseId,
                                                              for: indexPath) as? HelpCategoriesCell
                else { return nil }
                cell.configure(with: image)
                return cell
            }
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.reuseId,
                for: indexPath)
                    as? SectionHeader else { fatalError("can't create new section header")}
            guard let section = Section(rawValue: indexPath.section) else { fatalError("No section kind") }
            sectionHeader.configurate(text: section.description(), font: .textStyle2, textColor: .charcoalGrey)

            return sectionHeader
        }

        return dataSource
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()

        snapshot.appendSections([.mainSection])
        snapshot.appendItems(viewModel.categories.value, toSection: .mainSection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension HelpCategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("No section") }
        switch section {
        case .mainSection:
            guard let cell = collectionView.cellForItem(at: indexPath) as? HelpCategoriesCell
            else { return }
            viewModel.push(nav: navigationController ?? UINavigationController(),
                           title: cell.navBarTitle)
        }
    }
}

extension HelpCategoriesViewController: Storyboarded {}

private enum HelpConstants {
    static let title = "Помочь"

    enum Constraints {
        static let cellWidth: CGFloat = 174
        static let cellHeight: CGFloat = 160

        static let itemInset: CGFloat = 9
        static let topItemInset: CGFloat = UIDevice.current.name.contains("Max") ? 0 : 9
        static let groupSize = 2
        static let interGroupSpacing: CGFloat = 5
        static let interSectionSpacing: CGFloat = 20

        static let defaultNavBarHeight: CGFloat = 44.0
    }
}
