//
//  BorderViewController.swift
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/24.
//

import UIKit
import RxSwift
import RxGesture
import CropPickerView
import ColorCubeSwift


class BorderViewController: UIViewController {

    @IBOutlet weak var templateImageView: UIImageView!
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var cropPickerView: CropPickerView!
    
    fileprivate var templateImage:UIImage?
    fileprivate var desktopImage:UIImage?

    let bag = DisposeBag()
    let picker = UIImagePickerController()

    let colorCube = CCColorCube()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cropPickerView.delegate = self
        
        picker.delegate = self
        self.picker.allowsEditing = false

        templateImageView.rx.tapGesture()
            .skip(1)
            .subscribe(onNext: { _ in
                print("选择模板图片")
                self.picker.title = "模板图片"
                self.present(self.picker, animated: true)
            }).disposed(by: bag)
        
        
        cropPickerView.rx.tapGesture()
            .skip(1)
            .subscribe{ _ in
                print("选择桌面壁纸")
                self.picker.title = "剪切图片"
                self.picker.preferredContentSize = self.templateImage?.size ?? CGSize()
                self.present(self.picker, animated: true)
            }
            .disposed(by: bag)
        
        selectImageView.rx.tapGesture()
            .skip(1)
            .subscribe{_ in
                               
                self.cropPickerView.crop { (result) in
                    if let error = (result.error as NSError?) {
                        self.HSFAlert(msg: error.domain)
                    }
                    guard let templateSize = self.templateImageView.image?.size else {
                        self.HSFAlert(msg: "请先选择模板")
                        return
                    }
                    guard let imageCrop = result.image else{
                        self.HSFAlert(msg: "剪切图片不合格！")
                        return
                    }
                    print(templateSize)

                    guard let resizeImage = resizeImage(image: imageCrop, targetSize: templateSize) else { return }
                    print(resizeImage.size)
                    self.selectImageView.image = resizeImage.mergeWith(topImage: self.templateImage!)
                    print(resizeImage.size)


                }
            }
            .disposed(by: bag)
        selectImageView.rx.longPressGesture()
            .when(.ended)
            .subscribe{_ in
                guard let image = self.selectImageView.image else { return  }
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                self.HSFAlert(msg: "图片已保存，快去体验吧 kira~")
            }
            .disposed(by: bag)
    }

    
    func HSFAlert(msg:String){
        let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
// MARK: CropPickerViewDelegate
extension BorderViewController: CropPickerViewDelegate {
    func cropPickerView(_ cropPickerView: CropPickerView, result: CropResult) {
    }

    func cropPickerView(_ cropPickerView: CropPickerView, didChange frame: CGRect) {
        //print("frame: \(frame)")
    }
}

//MARK: - ImagePicker
extension BorderViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        switch picker.title{
        case "模板图片":
            print(self.colorCube.extractColors(fromImage: info[.originalImage] as! UIImage, withFlags: 1, count: 4))
            let colorArray = self.colorCube.extractColors(fromImage: info[.originalImage] as! UIImage, withFlags: 1, count: 2)
            templateImage = OpenCVWrapper.processImage(withOpenCV: info[.originalImage] as? UIImage,mainColor: colorArray.first)
            templateImageView.image = templateImage
        case "剪切图片":
            desktopImage = info[.originalImage] as? UIImage
            cropPickerView.image = desktopImage
        default:
            return
        }
        dismiss(animated: true)
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
