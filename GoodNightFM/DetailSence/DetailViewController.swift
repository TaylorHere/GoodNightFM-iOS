//
//  DetailViewController.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/12/7.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class DetailViewController: SharedElementViewController {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var controllButton: UIImageView!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var _title: UILabel!
    @IBOutlet weak var discovert_collection: UICollectionView!
    @IBOutlet weak var discover_label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setZpotions()
        setupAppearance()
        setupLayout()
        registerCell()
        setupDelegateAndDataSource()
        setDiscoverLabelTapGesture()
    }


}

// events
extension DetailViewController {

    func setDiscoverLabelTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.onTap))
        self.discover_label.isUserInteractionEnabled = true
        self.discover_label.addGestureRecognizer(tap)
    }

    @objc func onTap(sender: UITapGestureRecognizer) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: DiscoverViewController.self))
        self.navigationController?.pushViewController(toViewController, animated: true)
    }
}

// if do not set Z potions of those shared elements between tow sence, it will cause random view Occlusion
extension DetailViewController {
    
    func setZpotions() {
        self.cover.layer.zPosition = 0
        self.subtitle.layer.zPosition = 1
        self._title.layer.zPosition = 2
        self.controllButton.layer.zPosition = 3
    }
    
}

// Helpers Functions
extension DetailViewController {
    
    func setupAppearance() {
        self.discovert_collection.backgroundColor = UIColor(named: "dark")
    }
    
    func setupLayout() {
        self.discovert_collection.collectionViewLayout = PageCollectionLayout(itemSize: CGSize(width: 156, height: 139))
        self.discovert_collection.showsHorizontalScrollIndicator = false
    }
    
    func registerCell() {
        let nib = UINib(nibName: String(describing: TitleCardCell.self), bundle: nil)
        self.discovert_collection?.register(nib, forCellWithReuseIdentifier: String(describing: TitleCardCell.self))
    }
    
    func setupDelegateAndDataSource() {
        self.discovert_collection.delegate = self
        self.discovert_collection.dataSource = self
    }
    
}

// UICollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    
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
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TitleCardCell.self), for: indexPath)
    }
    
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }
    
}

