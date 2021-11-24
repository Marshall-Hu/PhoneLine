//
//  HomeViewController.swift
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/24.
//

import UIKit

class HomeViewController: UIViewController {

    let LineTypeArray = ["Border","CustomDocker","ExpandBezel","HideDocker","CustomLock"]
    
    @IBOutlet weak var funcCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initScrollViewUI()
    }
    
    func initScrollViewUI(){
        
        funcCollectionView.delegate = self
        funcCollectionView.dataSource = self
        funcCollectionView.register(FuncCollectionViewCell.self, forCellWithReuseIdentifier: "FuncCell")
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - CollectionView Delegate
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LineTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FuncCell", for: indexPath) as! FuncCollectionViewCell
        
        cell.imageview.image = UIImage(named: LineTypeArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var tempVC = UIViewController()
        
        switch indexPath.row{
        case 0:
            tempVC = BorderViewController()
            tempVC.title = LineTypeArray[indexPath.row]
        default:
            print("Not init")
            return
        }
        
        self.show(tempVC, sender: nil)
    }
    
}

//MARK: -自定义Layou & Cell
fileprivate let numberOfCell1row = 2.0
fileprivate let cellSize = 128.0

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellOffset = (collectionView.bounds.width - numberOfCell1row * cellSize) / 4.0
        
        return UIEdgeInsets(top: cellOffset, left: cellOffset, bottom: cellOffset, right: cellOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.bounds.width - numberOfCell1row * cellSize) / 4.0
    }
}

fileprivate class FuncCollectionViewCell: UICollectionViewCell {
    
    //var label:UILabel!
    var imageview:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageview = UIImageView(frame: frame)
        //imageview.layer.cornerRadius = 10.0
        
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        self.contentView.addSubview(imageview)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageview.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
