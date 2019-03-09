//
//  DiscoverViewController.swift
//  GoodNightFM
//
//  Created by taylor on 2019/3/9.
//  Copyright © 2019 李彦宏. All rights reserved.
//

import UIKit

class DiscoverViewController: SharedElementViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupLayout()
        setupAppearance()
        registerCell()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    }
    
}

// Helpers Functions
extension DiscoverViewController {
    
    func setupAppearance() {
        self.collectionView.backgroundColor = UIColor(named: "dark")
    }
    
    func setupLayout() {
        self.collectionView.collectionViewLayout = PageCollectionLayout(itemSize: CGSize(width: 280, height: 400))
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    func registerCell() {
        let nib = UINib(nibName: String(describing: TitleCardCell.self), bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: TitleCardCell.self))
    }
    
}

// UICollectionViewDelegate
extension DiscoverViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 280, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self))
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        self.navigationController?.pushViewController(toViewController, animated: true)
    }
    
}


// UICollectionViewDataSource
extension DiscoverViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCardCell.self), for: indexPath)
    }
    
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }
    
}
