//
//  MoviesCollectionViewController.swift
//  Movies
//
//  Created by Oleksandr Buhara on 4/19/22.
//

import UIKit

final class MoviesCollectionViewController: UICollectionViewController {
    private(set) var viewModel: MoviesCollectionViewModel

    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    weak var delegate: MoviesCollectionDelegate?

    enum SectionKind: Int, CaseIterable {
        case favorites, watched, towatch
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .favorites: return .paging
            case .watched: return .none
            case .towatch: return .none
            }
        }
        var columnCount: Int {
            switch self {
            case .favorites: return 4
            case .watched: return 1
            case .towatch: return 1
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.allowsMultipleSelection = true
        navigationItem.title = "Orthogonal Section Behaviors"
        configureDataSource()
        collectionView.delegate = self
    }

    init(_ viewModel: MoviesCollectionViewModel, collectionViewLayout: UICollectionViewLayout) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: collectionViewLayout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoviesCollectionViewController {
    func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var index = 0
        for i in 0..<viewModel.sectionsCount {
            guard let section = viewModel[i] else { return }
            snapshot.appendSections([section.type.rawValue])
            snapshot.appendItems(Array(index..<index + section.items.count))
            index += section.items.count
        }

        dataSource.apply(snapshot, animatingDifferences: false)
        collectionView.reloadData()
    }

    static func createLayout() -> UICollectionViewLayout {

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20

        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            guard let sectionKind = SectionKind(rawValue: sectionIndex) else { fatalError("unknown section kind") }

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)


            item.contentInsets = sectionKind.columnCount == 1 ? NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10) : NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)


            let groupHeight = sectionKind.columnCount == 1 ? NSCollectionLayoutDimension.absolute(74) : NSCollectionLayoutDimension.fractionalWidth(0.5)
            let groupWidth = sectionKind.columnCount == 1 ? NSCollectionLayoutDimension.fractionalWidth(1.0) : NSCollectionLayoutDimension.fractionalWidth(0.25)

            let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth,
                                                  heightDimension: groupHeight)

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior

            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(44)),
                elementKind: TitleSupplementaryView.reuseIdentifier,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }, configuration: config)

        return layout
    }

    func configureDataSource() {

        let cellRegistration = UICollectionView.CellRegistration<MovieCollectionViewCell, Int> { (cell, indexPath, identifier) in

            guard let section = self.viewModel[indexPath.section] else { return }

            let item = section.items[indexPath.item]

            if let imageData = item.imageData {
                cell.posterImageView.image = UIImage(data: imageData)
                cell.posterImageView.configure()
            }

            cell.label.text = item.title
            cell.configure(sectionType: section.type)
        }

        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: TitleSupplementaryView.reuseIdentifier) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = self.viewModel[indexPath.section]?.title
        }

        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let modelIndexPaths = viewModel.selectedIndexPaths else { return }
        let _ = modelIndexPaths
            .map{ IndexPath(item: $0.index, section: $0.section) }.forEach {
                collectionView.selectItem(at: $0, animated: false, scrollPosition: [])
            }
    }
}

extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.select(sectionIndex: indexPath.section, index: indexPath.item)
        guard let modelIndexPaths = viewModel.selectedIndexPaths else {
            return
        }

        let _ = modelIndexPaths
            .map{ IndexPath(item: $0.index, section: $0.section) }.forEach {
                collectionView.selectItem(at: $0, animated: true, scrollPosition: [])
            }

        delegate?.update()
    }

    private func deselect(_ collectionView: UICollectionView) {
        guard let modelIndexPaths = viewModel.selectedIndexPaths else { return }
        let selectedIndexPath = modelIndexPaths.map { IndexPath(item: $0.index, section: $0.section) }
        selectedIndexPath.forEach {
            collectionView.deselectItem(at: $0, animated: true)
        }
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        deselect(collectionView)
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        deselect(collectionView)
        viewModel.select(sectionIndex: indexPath.section, index: indexPath.item)
        self.delegate?.update()
        return true
    }
}
