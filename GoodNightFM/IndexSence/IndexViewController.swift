//
//  ViewController.swift
//  GoodNightFM
//
//  Created by 李彦宏 on 2018/11/30.
//  Copyright © 2018 李彦宏. All rights reserved.
//

import UIKit

class IndexViewController: UICollectionViewController {

    var use_transition = ContextPopTransition()
    var selectedFrame:CGRect? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAppearance()
        registerCell()
        configrateNavBar()
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
        let nib = UINib(nibName: String(describing: CradCell.self), bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: CradCell.self))
    }
    func configrateNavBar(){
//        navigationItem.leftBarButtonItem?.title = "hi"
        self.navigationController?.delegate = self
    }

}

// UICollectionViewDelegate
extension IndexViewController {
     func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 280, height: 400)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController = mainStoryboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self))
        self.selectedFrame = (collectionView.layoutAttributesForItem(at: indexPath)?.frame)!
        self.navigationController?.pushViewController(toViewController, animated: true)
    }

}


// UICollectionViewDataSource
extension IndexViewController {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CradCell.self), for: indexPath)

    }


    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 10
    }

}

extension IndexViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        switch operation {
        case .push:
            return ShareElementTrasition(duration: 0.34, isPresenting: true, originFrame: self.selectedFrame!, image: UIImage(named: "bitmap")!)
        default:
            return ShareElementTrasition(duration: 0.34, isPresenting: false, originFrame: self.selectedFrame!, image: UIImage(named: "bitmap")!)
        }
    }
    
}
