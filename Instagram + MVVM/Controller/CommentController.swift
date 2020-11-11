//
//  CommentController.swift
//  Instagram + MVVM
//
//  Created by Fomagran on 2020/11/11.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       configure()
      
    }
    
    //MAKR: Helpers
    
    func configure() {
        self.collectionView.backgroundColor = .white
        self.collectionView!.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

}

// MARK: UICollectionViewDelegate

// MARK: UICollectionViewDataSource
extension CommentController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        cell.backgroundColor = .black
    
        return cell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension CommentController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
