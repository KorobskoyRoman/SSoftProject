//
//  DetailEventViewController.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 19.07.2022.
//

import UIKit
import RealmSwift

final class DetailEventViewController: UIViewController {

    var eventInfo = [RealmEvent]()
    private lazy var tableView = UITableView(frame: view.bounds, style: .plain)
    private var images = [UIImageView(image: UIImage(named: "childs1")), UIImageView(image: UIImage(named: "childs2")),
                          UIImageView(image: UIImage(named: "adults1")), UIImageView(image: UIImage(named: "aged1")),
//                          ] // можно проверить на количество картинок расскоментив эту строку и комментнуть нижнюю
                          UIImageView(image: UIImage(named: "events1")), UIImageView(image: UIImage(named: "events2"))]

    private lazy var footerView = TableFooterView(images: images)
    private let helpVariants = HelpVariantsView()

    private lazy var shareButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
    }()
    private lazy var backButton: UIBarButtonItem = {
        return UIBarButtonItem(image: ImageConstants.backImage,
                               style: .plain,
                               target: self,
                               action: #selector(backButtonPresed))
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
            self.tabBarController?.tabBar.alpha = self.tabBarController?.tabBar.alpha == 1 ? 0 : 1
        },
                       completion: nil)
    }

    private func setupView() {
        title = eventInfo[0].title
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = backButton
        helpVariants.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(helpVariants)
        helpVariants.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        helpVariants.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        helpVariants.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                             constant: -ConstraintsConst.inset20).isActive = true
        helpVariants.heightAnchor.constraint(equalToConstant: ConstraintsConst.inset70).isActive = true
        navigationItem.rightBarButtonItem = shareButton
    }

    private func setupTableView() {
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: helpVariants.topAnchor).isActive = true
        tableView.register(DetailEventCell.self, forCellReuseIdentifier: DetailEventCell.reuseId)
    }

    @objc private func shareButtonTapped() {
        print("shareButtonTapped")
    }

    @objc private func backButtonPresed() {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SizesDetailsEvent.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailEventCell.reuseId,
                                                 for: indexPath) as? DetailEventCell
        else { return UITableViewCell() }
        cell.configure(from: (eventInfo[indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return SizesDetailsEvent.heightForFooterInSection
    }
}

extension DetailEventViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SizesDetailsEvent.heightForRowAt
    }
}

private enum SizesDetailsEvent {
    static let numberOfRowsInSection = 1
    static let heightForFooterInSection: CGFloat = 68
    static let heightForRowAt: CGFloat = 685
}
