//
//  HelpCategoriesViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 12.07.2022.
//

import UIKit

class HelpCategoriesViewController: UIViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Categories>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Categories>

    private lazy var collectionView = UICollectionView(frame: view.bounds,
                                                       collectionViewLayout: createCompositialLayout())
    private lazy var dataSource = createDiffableDataSource()
    private var categories = [Categories]()
    private let setupCategories = SetupCategories()
    private lazy var backButton: UIBarButtonItem = {
        return UIBarButtonItem(image: HelpConstants.backImage,
                               style: .plain,
                               target: self,
                               action: #selector(backButtonTapped))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.topItem?.title = HelpConstants.title
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
        categories = setupCategories.createItems()
        setupCollectionView()
        applySnapshot()
    }

    // Почему-то не работает, скорее всего как-то криво вставил навигейшн, нужна помощь
    @objc private func backButtonTapped() {
        print("backButtonTapped")
        exit(0)
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
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .fractionalHeight(1.0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(HelpConstants.Constraints.cellWidth),
                                              heightDimension: .absolute(HelpConstants.Constraints.cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(top: .zero,
                                                     leading: HelpConstants.Constraints.itemInset,
                                                     bottom: HelpConstants.Constraints.itemInset,
                                                     trailing: HelpConstants.Constraints.itemInset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               // тут и ниже оставил тк это пропорции
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: HelpConstants.Constraints.groupSize)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = HelpConstants.Constraints.interGroupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(top: HelpConstants.Constraints.interSectionSpacing,
                                                        leading: HelpConstants.Constraints.itemInset,
                                                        bottom: HelpConstants.Constraints.itemInset,
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCategoriesCell.reuseId,
                                                              for: indexPath) as? HelpCategoriesCell
                // configure
                guard let cell = cell else { return nil }
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
        snapshot.appendItems(categories, toSection: .mainSection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

private enum HelpConstants {
    static let title = "Помочь"
    static let backImage = UIImage(named: "backButton")

    enum Constraints {
        static let cellWidth: CGFloat = 174
        static let cellHeight: CGFloat = 160

        static let itemInset: CGFloat = 9
        static let groupSize = 2
        static let interGroupSpacing: CGFloat = 5
        static let interSectionSpacing: CGFloat = 20
    }
}
