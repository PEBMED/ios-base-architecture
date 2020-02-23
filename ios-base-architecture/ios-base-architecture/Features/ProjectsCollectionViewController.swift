//
//  ViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 21/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class ProjectsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var itens = [Repository]()
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        registerCells()
        NetworkManager.shared.fetchData(stringURL: "https://api.github.com/search/repositories?q=topic:javascript&per_page=20", type: SearchRepositories.self) { (result) in
            switch result{
            case .success(let repositories):
                let _ = repositories.items.map { (repository) -> RepositoryViewModelItem in
                    return RepositoryViewModelItem(name: repository.name, description: repository.description, avatarUrl: repository.owner.avatarUrl, stargazersCount: repository.stargazersCount, forksCount: repository.forksCount, openIssuesCount: repository.openIssuesCount, ownerName: repository.owner.login)
                }
            case .failure(let error):
                    print(error)
            }
        }
    }
    
    func setupController(){
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        navigationItem.title = "Projects"
    }
    
    func registerCells(){
        collectionView.register(ProjectsCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itens.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {        
        return ProjectsCollectionViewCell.getCellHeight(with: "If you are using react, wrap your root component with PersistGate. This delays the rendering of your app's")
    }
}

class ProjectsCollectionViewCell: UICollectionViewCell {
    let avatarImageView = GHAvatarImageView(size: CGSize(width: 70, height: 70))
    let titleLabel = GHTitleLabel()
    let companyLabel = GHSecondaryLabel()
    let desciprionLabel = GHBodyLabel()
    let separatorView = SeparatorView()
    
    static func getCellHeight(with text: String)->CGSize{
        let padding:CGFloat = 36
        let label = GHBodyLabel()
        label.text = text
        let labelHeight = label.height(width: UIScreen.main.bounds.width - 114)
        let height:CGFloat = 116 + (labelHeight - 36)
        return CGSize(width: UIScreen.main.bounds.width - padding, height: height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        setupHeader()
        setupProjectInfoStackView()
    }
    
    func setupHeader(){
        avatarImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        let titleLabelStackView = UIStackView(arrangedSubviews: [titleLabel, companyLabel, UIView()])
        titleLabelStackView.spacing = 8
        titleLabelStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let labelStackView = UIStackView(arrangedSubviews: [titleLabelStackView, desciprionLabel])
        labelStackView.axis = .vertical
        labelStackView.isLayoutMarginsRelativeArrangement = true
        labelStackView.layoutMargins = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        labelStackView.spacing = 6
        
        let headerStackView = UIStackView(arrangedSubviews: [avatarImageView, labelStackView])
        headerStackView.alignment = .top
        headerStackView.spacing = 8
        
        addSubviews(headerStackView)
        
        headerStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func setupProjectInfoStackView(){
        let stackView = UIStackView(arrangedSubviews: [ProjectInfoView(imageName: "star.fill", value: 12), ProjectInfoView(imageName: "arrow.merge", value: 15), ProjectInfoView(imageName: "exclamationmark.circle", value: 12), UIView()])
         stackView.distribution = .equalSpacing
        
        addSubviews(stackView, separatorView)
        
        stackView.anchor(top: desciprionLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 14), size: CGSize(width: 0, height: 19))
        
        separatorView.anchor(top: stackView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 1))
    }
    
    func set(){
        titleLabel.text = "Javascript"
        companyLabel.text = "• AirBnb"
        desciprionLabel.text = "If you are using react, wrap your root component with PersistGate. This delays the rendering of your app's"
    }
}
