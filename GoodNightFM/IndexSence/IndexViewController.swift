//
//  ViewController.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/11/30.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class IndexViewController: SharedElementViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAppearance()
        registerCell()
        
    }

}

// Helpers Functions
extension IndexViewController {

    func setupAppearance() {
        self.collectionView.backgroundColor = UIColor(named: "dark")
    }

    func setupLayout() {
        self.collectionView.collectionViewLayout = PageCollectionLayout(itemSize: CGSize(width: 280, height: 400))
        self.collectionView.showsHorizontalScrollIndicator = false
    }

    func registerCell() {
        let nib = UINib(nibName: String(describing: CardCell.self), bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: CardCell.self))
    }

}

// UICollectionViewDelegate
extension IndexViewController: UICollectionViewDelegate {

     func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 280, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self))
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        self.selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview!.superview)
        self.selectedCell = collectionView.cellForItem(at: indexPath)
        self.navigationController?.pushViewController(toViewController, animated: true)
    }

}


// UICollectionViewDataSource
extension IndexViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardCell.self), for: indexPath)
    }


    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }

}

