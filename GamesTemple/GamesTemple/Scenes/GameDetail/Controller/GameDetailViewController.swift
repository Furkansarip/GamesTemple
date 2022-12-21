//
//  GameDetailViewController.swift
//  GamesTemple
//
//  Created by Furkan Sarı on 11.12.2022.
//

import UIKit

final class GameDetailViewController: BaseViewController {
    
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    //MARK: Detail StackView
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var suggestionCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var releasedLabel: UILabel!
    //MARK: Platform StackView
    @IBOutlet weak var phoneLogo: UIImageView!
    @IBOutlet weak var pcLogo: UIImageView!
    @IBOutlet weak var xboxLogo: UIImageView!
    @IBOutlet weak var playstationLogo: UIImageView!
    //MARK: Genre
    @IBOutlet weak var genreLabel: UILabel!
    //MARK: Description
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    // MARK: Models - Images - Texts & ID
    var isFavorite: Bool = false
    private var logosImage = [UIImageView]()
    var gameId : Int?
    private var viewModel = GameDetailViewModel()
    var screenshots = [Screenshots]()
    private var genreText = ""
    var timer : Timer? //Slayt için timer eklendi.
    var currentImageIndex = 0
    
    //MARK: Genres
    var genreList : [Genre]? {
        didSet { //Eklenen her tür aralarına - konularak formatlanıyor.
            for genre in genreList ?? [] {
                genreText += "\(genre.name)-"
            }
            
        }
    }
    //MARK: Platforms
    var platformList : [ParentPlatform]? {
        didSet {
            for parent in platformList ?? [] {
                let result = parent.platform.name
                switch result {// Gelen dataya göre var olan platformların aktifliği görsel olarak değişiyor.
                case "PC":
                    pcLogo.image = UIImage(systemName: "laptopcomputer")
                    pcLogo.tintColor = .systemPink
                case "PlayStation":
                    playstationLogo.image = UIImage(systemName: "playstation.logo")
                    playstationLogo.tintColor = .systemPink
                case "Xbox":
                    xboxLogo.image = UIImage(systemName: "xbox.logo")
                    xboxLogo.tintColor = .systemPink
                default:
                    phoneLogo.image = UIImage(systemName: "iphone")
                    phoneLogo.tintColor = .systemPink
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        if isFavorite {
            favoriteButton.image = UIImage(systemName: "heart.fill")
        }
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.7
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        guard let id = gameId else { return }
        viewModel.delegate = self
        viewModel.fetchGame(id: id)
        pageView.numberOfPages = screenshots.count // Screenshots sayısı kadar sayfa geçişi sağlanacak.
        startTimer()
        
    }
    //MARK: Slide Actions
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(nextSlide), userInfo: nil, repeats: true)
    }
    
    @objc func nextSlide(){ 
        
        if currentImageIndex < screenshots.count - 1 {
            currentImageIndex += 1
        } else {
            currentImageIndex = 0
        }
        
        imagesCollectionView.scrollToItem(at: IndexPath(item: currentImageIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageView.currentPage = currentImageIndex
    }
    //MARK: Favorite Actions
    @IBAction func favoriteAction(_ sender: Any) {
        isFavorite = !isFavorite
        if (isFavorite) {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            guard let detailName = viewModel.gameDetail?.name,let detailImage = viewModel.gameDetail?.backgroundImage,let favoriteId = gameId else { return }
            FavoriteCoreDataManager.shared.saveGame(gameName:detailName, gameImage:detailImage,id: String(favoriteId))
            
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
            guard let deleteGameName = viewModel.gameDetail?.name else { return }
            FavoriteCoreDataManager.shared.deleteFavoriteGame(name: deleteGameName)
        }
    }
    
}

//MARK: GameDetailViewModelDelegate
extension GameDetailViewController : GameDetailViewModelDelegate {
    func gameDetailLoaded() {
        indicator.stopAnimating()
        genreList = viewModel.gameDetail?.genres
        genreText.removeLast()
        DispatchQueue.main.async {//Gelen verilerin işlenmesi
            self.nameLabel.text = "Name: \(self.viewModel.gameDetail?.name ?? "")"
            self.suggestionCountLabel.text = "Suggestion Count : \(self.viewModel.gameDetail?.suggestionsCount ?? 0)"
            self.ratingLabel.text = "Rating : \(self.viewModel.gameDetail?.rating ?? 0.0)"
            self.ratingsCountLabel.text = "Ratings Count : \(self.viewModel.gameDetail?.ratingsCount ?? 0)"
            self.releasedLabel.text = "Released : \(self.viewModel.gameDetail?.released ?? "")"
            self.genreLabel.text = self.genreText
            self.descriptionLabel.text = self.viewModel.gameDetail?.description
            self.genreList? = self.viewModel.gameDetail?.genres ?? []
            self.platformList = self.viewModel.gameDetail?.parentPlatforms
            
        }
    }
    
    func gameDetailFail(error: ErrorModel) {
        DispatchQueue.main.async {
            self.showErrorAlert(message: error.rawValue)
        }
    }
    
}

//MARK: CollectionView
extension GameDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as? SlideCollectionViewCell,let imageURL = URL(string: screenshots[indexPath.item].image) else { return UICollectionViewCell() }
        cell.configure(screenshot: imageURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
