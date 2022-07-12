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
    
    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositialLayout())
    private lazy var dataSource = createDiffableDataSource()
    private var categories = [Categories]()
    private let setupCategories = SetupCategories()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground()
        categories = setupCategories.createItems()
        setupCollectionView()
        applySnapshot()
        print(categories)
    }
    
    private func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositialLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        view.addSubview(collectionView)
        
        collectionView.register(HelpCategoriesCell.self, forCellWithReuseIdentifier: HelpCategoriesCell.reuseId)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
    }
}

// MARK: - Create layout
extension HelpCategoriesViewController {
    private func createCompositialLayout() ->  UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnviroment in
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Section not found")
            }
            switch section {
            case .mainSection:
                return self.createMainSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createMainSection() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .fractionalHeight(1.0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(174), heightDimension: .absolute(160))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 9, bottom: 9, trailing: 9)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                
        let section = NSCollectionLayoutSection(group: group)
    
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 9, bottom: 9, trailing: 9)
        
        let sectionHeader = createHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.5), heightDimension: .estimated(1.5))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
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
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HelpCategoriesCell.reuseId, for: indexPath) as! HelpCategoriesCell
                // configure
                cell.configure(with: image)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("can't create new section header")}
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
