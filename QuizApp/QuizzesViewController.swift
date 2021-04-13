//
//  QuizzesViewController.swift
//  QuizApp
//
//  Created by five on 12/04/2021.
//

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
    private var quizzesByCategory: [QuizCategory: [Quiz]]!
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViews()
        addConstraints()
    }

    private func buildViews() {
        view.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)

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
        
        //This is initialized only if the user pressed get quizzes beforehand
        if(quizzes != nil) {
            funFactLabel = UILabel()
            funFactLabel.text = "Fun Fact"
            funFactLabel.textColor = .white
            funFactLabel.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.bold)
            
            let lightBulbIcon = UIImage(systemName: "lightbulb.fill")
            lightBulb = UIImageView(image: lightBulbIcon)
            lightBulb.tintColor = .systemYellow
            // getting the number of questions that contain "NBA"
            let numberOfQWithNBA = quizzes.flatMap{$0.questions}.filter{$0.question.contains("NBA")}
            
            //fun fact label initialization
            funFactText = UILabel()
            funFactText.text = "There are \(numberOfQWithNBA.count) questions that contain the word \"NBA\""
            funFactText.textColor = .white
            funFactText.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            funFactText.lineBreakMode = .byWordWrapping
            funFactText.numberOfLines = 7
            
            
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: view.frame.width - 20, height: 200)
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            flowLayout.scrollDirection = .vertical
            flowLayout.headerReferenceSize = CGSize(width: view.frame.width, height: 20)
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 700 , width: (view.frame.width - 20), height: 10), collectionViewLayout: flowLayout)
            collectionView.backgroundColor = UIColor(red:0.49, green: 0.26, blue: 0.96, alpha: 1.0)
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
            collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellHeader")
            collectionView.dataSource = self
            collectionView.delegate = self
            
            view.addSubview(funFactLabel)
            view.addSubview(funFactText)
            view.addSubview(collectionView)
            view.addSubview(lightBulb)

        }
        
        view.addSubview(headerText)
        view.addSubview(getQuizzesButton)
        


    }

    private func addConstraints() {
        headerText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerText.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            headerText.heightAnchor.constraint(equalToConstant: 70),
            headerText.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20 )
        ])
        
        getQuizzesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getQuizzesButton.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 35),
            getQuizzesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            getQuizzesButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -64),
            getQuizzesButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        if(quizzes != nil) {
            funFactLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                funFactLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                funFactLabel.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 55),
                funFactLabel.heightAnchor.constraint(equalToConstant: 70),
                funFactLabel.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20 )
            ])
            lightBulb.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                lightBulb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                lightBulb.topAnchor.constraint(equalTo: getQuizzesButton.bottomAnchor, constant: 80),
                
            ])
            
            
            funFactText.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                funFactText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                funFactText.topAnchor.constraint(equalTo: funFactLabel.bottomAnchor),
                funFactText.widthAnchor.constraint(equalTo: view.widthAnchor,constant: -20 ),
            ])
            
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.topAnchor.constraint(equalTo: funFactText.bottomAnchor,constant: 20),
                collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            
        
            
        }
    }
    
    @objc func getQuizzes() {
        let dataService = DataService()
        quizzes = dataService.fetchQuizes()
        quizzesByCategory = Dictionary(grouping: quizzes, by: { $0.category})
        viewDidLoad()
    }
   
}

extension QuizzesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Array(quizzesByCategory)[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        cell.contentView.backgroundColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.4)
        cell.contentView.layer.cornerRadius = 20.0
        
        
        let quiz = Array(quizzesByCategory)[indexPath.section].value
        let certainQuiz = quiz[indexPath.row]
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
            stars[i].tintColor = .systemYellow
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
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeader", for: indexPath)
            
            var textForSection = ""
            if(Array(quizzesByCategory.keys)[indexPath.section] == .science) {
                textForSection = "Science"
            } else {
                textForSection = "Sport"
            }
                
            let lab = UILabel()
            lab.text = textForSection
            lab.textColor = .yellow
            lab.frame = headerView.frame
            lab.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
            lab.frame.origin.x = 20
            headerView.addSubview(lab)
            return headerView
        default:
            assert(false, "Unexpected")
        
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return quizzesByCategory.keys.count
    }
    
   
}

extension QuizzesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

