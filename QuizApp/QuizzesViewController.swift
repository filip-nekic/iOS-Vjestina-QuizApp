import Foundation
import UIKit

class QuizzesViewController: UIViewController {
    
    private var headerText: UILabel!
    private var funFactLabel: UILabel!
    private var funFactText: UILabel!
    private var getQuizzesButton: UIButton!
    private var collectionView: UICollectionView!
    private var lightBulb: UIImageView!
    private var quizzes: [Quiz]!
    private var quizzesByCategory: [[Quiz]]!
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    var username: String
    let cellIdentifier = "cellId"
    
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }
    
    private func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        contentView = UIView()
        scrollView.addSubview(contentView)
            
        
        //header label "PopQuiz"
        headerText = UILabel()
        headerText.text = "PopQuiz"
        headerText.textColor = .white
        headerText.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        headerText.textAlignment = .center
        
        // Get Quizzes button
        getQuizzesButton = UIButton()
        let loginAttributes :[NSAttributedString.Key:Any] = [
            .font : UIFont.systemFont(ofSize: 17.0, weight:UIFont.Weight.bold),
            .foregroundColor: UIColor.purple
        ]
        getQuizzesButton.setAttributedTitle(NSAttributedString(string: "Get Quiz", attributes: loginAttributes), for: .normal)
        getQuizzesButton.layer.cornerRadius = 26.0
        getQuizzesButton.addTarget(self, action: #selector(getQuizzes), for: .touchUpInside)
        getQuizzesButton.backgroundColor = .white
        
        funFactLabel = UILabel()
        funFactLabel.textColor = .white
        funFactLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
        
        lightBulb = UIImageView()
        lightBulb.tintColor = .systemYellow
        
        
        //fun fact label initialization
        funFactText = UILabel()
        funFactText.textColor = .white
        funFactText.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        funFactText.lineBreakMode = .byWordWrapping
        funFactText.numberOfLines = 7
        
        
        //quizzes and their layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (view.frame.width - 20), height: 200)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 20)
        flowLayout.sectionHeadersPinToVisibleBounds = false
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 700 , width: (contentView.frame.width - 20), height: 10), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
        
        
        contentView.addSubview(funFactLabel)
        contentView.addSubview(funFactText)
        contentView.addSubview(collectionView)
        contentView.addSubview(lightBulb)
        
        contentView.addSubview(headerText)
        contentView.addSubview(getQuizzesButton)
        
        
    }
    
    private func addConstraints() {
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            headerText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            headerText.heightAnchor.constraint(equalToConstant: 70),
            headerText.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -20 )
        ])
        
        getQuizzesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getQuizzesButton.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 35),
            getQuizzesButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            getQuizzesButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -65),
            getQuizzesButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        funFactLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            funFactLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            funFactLabel.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 55),
            funFactLabel.heightAnchor.constraint(equalToConstant: 70),
            funFactLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -20 )
        ])
        lightBulb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lightBulb.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            lightBulb.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 80),
            
        ])
        
        
        funFactText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            funFactText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            funFactText.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor,  constant: 10),
            funFactText.widthAnchor.constraint(equalTo: contentView.widthAnchor,constant: -20 ),
        ])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: funFactText.bottomAnchor,constant: 20),
            collectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
    }
    // method that gets quizzes after button "Get Quiz" is pressed
    @objc func getQuizzes() {
        
    let networkService = QuizNetworkDataSource()
        var req = networkService.getRequest()
        
        networkService.executeUrlRequest(req) { (result: Result<QuizzesResponse, RequestError>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let value):
                self.quizzes = value.quizzes
                let dict = Dictionary(grouping: self.quizzes, by: { $0.category})
                self.quizzesByCategory = dict.map{ $0.value }
                self.funFactLabel.text = "Fun Fact"
                
                // getting the number of questions that contain "NBA"
                let numberOfQWithNBA = self.quizzes.flatMap{$0.questions}.filter{$0.question.contains("NBA")}
                self.funFactText.text = "There are \(numberOfQWithNBA.count) questions that contain the word \"NBA\""
                
                let lightBulbIcon = UIImage(systemName: "lightbulb.fill")
                self.lightBulb.image = lightBulbIcon
                
                self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
                self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellHeaderSection0")
                self.collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellHeaderSection1")
                self.collectionView.dataSource = self
                self.collectionView.delegate = self
                
                NSLayoutConstraint.activate([
                    self.collectionView.heightAnchor.constraint(equalToConstant: self.collectionView.collectionViewLayout.collectionViewContentSize.height)
                ])
            }
        }
        
    }
    
}

extension QuizzesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizzesByCategory[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        cell.contentView.layer.cornerRadius = 20.0
        
        
        let certainQuiz = quizzesByCategory[indexPath.section][indexPath.row]
        let quizDescription = certainQuiz.description
        
        let index = certainQuiz.imageUrl.lastIndex(of: "/")
        let cropped = certainQuiz.imageUrl.substring(from: index!)
        
        let labelHeadline = UILabel()
        labelHeadline.text = certainQuiz.title
        labelHeadline.textColor = .white
        labelHeadline.frame = CGRect(x: 25 + 130 + 15, y: 20, width: cell.contentView.bounds.width - 130 - 25 - 15, height: 90)
        labelHeadline.numberOfLines = 7
        labelHeadline.lineBreakMode = .byWordWrapping
        labelHeadline.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.bold)
        
        let labelDescription = UILabel()
        labelDescription.text = quizDescription
        labelDescription.textColor = .white
        labelDescription.frame = CGRect(x: 25 + 130 + 15, y: 60 + 30, width: cell.contentView.bounds.width - 130 - 25 - 15, height: 90)
        labelDescription.numberOfLines = 7
        labelDescription.lineBreakMode = .byWordWrapping
        
        let imageView = UIImageView(image: UIImage(named: "Pictures" + cropped))
        imageView.frame = CGRect(x:25, y: 30, width: 130, height: cell.contentView.frame.height - 60)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20.0
        
        let firstStar  = UIImageView()
        let secondStar = UIImageView()
        let thirdStar = UIImageView()
        
        let stars = [firstStar, secondStar, thirdStar]
        let grade = certainQuiz.level
        var i = 0
        while(i < grade) {
            stars[i].tintColor = indexPath.section == 0 ? .systemYellow : .systemBlue
            i += 1
        }
        while(i < stars.count) {
            stars[i].tintColor = .systemGray
            i += 1
        }
        i = 0
        while(i < stars.count) {
            stars[i].image = UIImage(systemName: "rhombus.fill")
            stars[i].frame = CGRect(x: (cell.contentView.frame.width - 60.0 - 10.0 + CGFloat(Float(i * 20)))  , y: 10, width: 20, height: 20)
            cell.contentView.addSubview(stars[i])
            i += 1
        }
        
        cell.contentView.addSubview(labelHeadline)
        cell.contentView.addSubview(labelDescription)
        cell.contentView.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeaderSection" + String(indexPath.section), for: indexPath)
            
            let lab = UILabel()
            lab.text = quizzesByCategory[indexPath.section][0].category.rawValue.capitalized
            lab.textColor = indexPath.section == 0 ? .systemYellow : .systemBlue
            lab.frame = CGRect(x:20, y:0, width: view.frame.width, height: 20)
            lab.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            headerView.addSubview(lab)
            return headerView
        default:
            assert(false, "Unexpected")
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return quizzesByCategory.count
    }
    
    
}

extension QuizzesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(QuizViewController(quiz: quizzesByCategory[indexPath.section][indexPath.row]), animated: true)
    }
}
