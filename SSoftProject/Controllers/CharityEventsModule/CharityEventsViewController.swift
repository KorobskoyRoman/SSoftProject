//
//  CharityEventsViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 15.08.2022.
//

import UIKit

final class CharityEventsViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, RealmEvent>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RealmEvent>

    var presenter: CharityEventsPresenterProtocol?
    let configurator: CharityEventsConfiguratorProtocol = CharityEventsVCConfigurator()
    private var containerView = UIView()
    private var collView = UIView()
    private lazy var collectionView = UICollectionView(frame: collView.bounds,
                                                       collectionViewLayout: createCompositialLayout())
    private lazy var dataSource = createDiffableDataSource()
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
        segmentedControl.insertSegment(withTitle: HelpConstants.segmentCurrentTitle,
                                       at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: HelpConstants.segmentEndedTitle,
                                       at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangeState(_:)), for: .valueChanged)
        return segmentedControl
    }()
    private lazy var backButton: UIBarButtonItem = {
        return UIBarButtonItem(image: ImageConstants.backImage,
                               style: .plain,
                               target: self,
                               action: #selector(backButtonPressed))
    }()
    private lazy var catName = self.navigationItem.title

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(with: self)
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        guard let alpha = tabBarController?.tabBar.alpha else { return }
        if alpha == 0 {
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseIn,
                           animations: {
                self.tabBarController?.tabBar.alpha = 1
            }, completion: nil)
        }
    }

    private func setConstraints() {
        var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0) + 5
        }
        var tabBarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.tabBarController?.tabBar.frame.height ?? 0.0)
        }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        collView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(containerView)
        containerView.addSubview(segmentedControl)
        view.addSubview(collView)
        collView.addSubview(collectionView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight*2),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: ConstraintsConst.inset43),

            segmentedControl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ConstraintsConst.inset10),
            segmentedControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                      constant: ConstraintsConst.inset16),
            segmentedControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                       constant: -ConstraintsConst.inset16),
            segmentedControl.heightAnchor.constraint(equalToConstant: ConstraintsConst.inset23and5),

            collView.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            collView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -tabBarHeight)
        ])
    }
}

extension CharityEventsViewController: CharityEventsViewProtocol {
    @objc func segmentedControlChangeState(_ sender: UISegmentedControl) {
        getSegmentData(sender.selectedSegmentIndex,
                       catName ?? "")
    }

    func getSegmentData(_ index: Int,
                        _ catName: String) {
        presenter?.getSegmentData(index, catName)
    }

    func setupView() {
        containerView.backgroundColor = .white
        collView.backgroundColor = .mainBackground()
        view.backgroundColor = .mainBackground()
        navigationItem.leftBarButtonItem = backButton
        setConstraints()
        setupCollectionView()
        reload()
        fetchEvents(for: catName ?? "")
    }

    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.heightAnchor.constraint(equalTo: collView.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: collView.widthAnchor).isActive = true
        collectionView.register(CharityCell.self, forCellWithReuseIdentifier: CharityCell.reuseId)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
    }

    @objc func backButtonPressed() {
        presenter?.backButtonPressed()
    }

    func createCompositialLayout() -> UICollectionViewLayout {
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

    func createMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(HelpConstants.Constraints.cellWidth),
                                              heightDimension: .absolute(HelpConstants.Constraints.cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        item.contentInsets = NSDirectionalEdgeInsets(
            top: HelpConstants.Constraints.topItemInset,
            leading: HelpConstants.Constraints.itemInset,
            bottom: HelpConstants.Constraints.itemInset,
            trailing: HelpConstants.Constraints.itemInset)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(HelpConstants.Constraints.cellHeight))
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

    func createDiffableDataSource() -> UICollectionViewDiffableDataSource<Section, RealmEvent> {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, model in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("No section")
            }
            switch section {
            case .mainSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharityCell.reuseId,
                                                                    for: indexPath) as? CharityCell
                else { return nil }
                // configure
                cell.configure(with: model)
                return cell
            }
        }
        return dataSource
    }

    func applySnapshot(animatingDifferences: Bool) {
        var snapshot = Snapshot()

        snapshot.appendSections([.mainSection])
        snapshot.appendItems(presenter?.filteredEvents ?? [], toSection: .mainSection)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    func fetchEvents(for name: String) {
        self.presenter?.fetchEvents(for: name)
    }

    private func reload() {
        presenter?.reload = { [weak self] in
            guard let self = self else { return }
            self.applySnapshot(animatingDifferences: true)
        }
    }
}

private enum HelpConstants {
    static let title = "Помочь"
    static let segmentCurrentTitle = "Текущие"
    static let segmentEndedTitle = "Завершенные"

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
