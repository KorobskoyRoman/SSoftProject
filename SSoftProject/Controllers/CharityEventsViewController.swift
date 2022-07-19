//
//  CharityEventsViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 18.07.2022.
//

import Foundation
import UIKit

class CharityEventsViewController: UIViewController {

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Event>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Event>

    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.selectedSegmentTintColor = .leaf
        segmentedControl.tintColor = .white
        segmentedControl.backgroundColor = .white
        let titleGreen = [NSAttributedString.Key.foregroundColor: UIColor.leaf,
                          NSAttributedString.Key.font: UIFont.textStyle9]
        let titleWhite = [NSAttributedString.Key.foregroundColor: UIColor.white,
                          NSAttributedString.Key.font: UIFont.textStyle9]
        segmentedControl.setTitleTextAttributes(titleGreen, for: .normal)
        segmentedControl.setTitleTextAttributes(titleWhite, for: .selected)
        segmentedControl.insertSegment(withTitle: "Текущие", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Завершенные", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()

    private let decodeService = JSONDecoderService()
    private var containerView = UIView()
    private var collView = UIView()
    private lazy var collectionView = UICollectionView(frame: collView.bounds,
                                                       collectionViewLayout: createCompositialLayout())
    private lazy var dataSource = createDiffableDataSource()
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .mainBackground()
        collectionView.delegate = self
        setupView()
        applySnapshot()
        print(events)
    }

    private func setupView() {
        containerView.backgroundColor = .white
        collView.backgroundColor = .mainBackground()
        view.backgroundColor = .mainBackground()

        setConstraints()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.heightAnchor.constraint(equalTo: collView.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: collView.widthAnchor).isActive = true
        collectionView.register(CharityCell.self, forCellWithReuseIdentifier: CharityCell.reuseId)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
    }

    private func setConstraints() {
        var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        collView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(containerView)
        containerView.addSubview(segmentedControl)
        view.addSubview(collView)
        collView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight*2 + 5),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 43),

            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 23.5),

            collView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CharityEventsViewController {
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
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: HelpConstants.Constraints.groupSize)

        let section = NSCollectionLayoutSection(group: group)

        section.interGroupSpacing = HelpConstants.Constraints.interGroupSpacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: HelpConstants.Constraints.topItemInset,
            leading: HelpConstants.Constraints.itemInset,
            bottom: HelpConstants.Constraints.itemInset,
            trailing: HelpConstants.Constraints.itemInset)

        return section
    }
}

extension CharityEventsViewController {
    private func createDiffableDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("No section")
            }
            switch section {
            case .mainSection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharityCell.reuseId,
                                                              for: indexPath) as? CharityCell
                // configure
                guard let cell = cell else { return nil }
                cell.configure(with: model)
                return cell
            }
        }

        return dataSource
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()

        snapshot.appendSections([.mainSection])
        snapshot.appendItems(events, toSection: .mainSection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension CharityEventsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { fatalError("No section") }
        switch section {
        case .mainSection:
            let cell = collectionView.cellForItem(at: indexPath) as? CharityCell
            guard let cell = cell else { return }
            let detailsVC = DetailEventViewController()
            detailsVC.title = cell.title.text
            detailsVC.eventInfo = events.filter { $0.id == indexPath.item }
            navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

private enum HelpConstants {
    static let title = "Помочь"
    static let backImage = UIImage(named: "backButton")

    enum Constraints {
        static let cellWidth: CGFloat = 359
        static let cellHeight: CGFloat = 413

        static let itemInset: CGFloat = 9
        static let topItemInset: CGFloat = 10
        static let groupSize = 1
        static let interGroupSpacing: CGFloat = 5
        static let interSectionSpacing: CGFloat = 20

        static let defaultNavBarHeight: CGFloat = 44.0
    }
}
