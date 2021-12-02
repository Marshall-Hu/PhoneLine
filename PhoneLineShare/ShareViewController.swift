//
//  ShareViewController.swift
//  PhoneLineShare
//
//  Created by Mini-M14Marshaii on 2021/12/2.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController,ColorSelectionViewControllerDelegate {

    let suiteName = "group.PhoneLine.ShareImage"
    let templateImageKey = "templateImageKey"
    
    var selectedColorName = "模板图片"

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        
        if let content = extensionContext!.inputItems[0] as? NSExtensionItem {
            let contentType = kUTTypeImage as String
            
            // Verify the provider is valid
            if let contents = content.attachments {
                
                // look for images
                for attachment in contents {
                    if attachment.hasItemConformingToTypeIdentifier(contentType) {
                        attachment.loadItem(forTypeIdentifier: contentType, options: nil) { data, error in
                            print("￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥￥")

                            if (!self.selectedColorName.isEmpty) {
                                if let url = data as? URL{
                                    if let imageData = try? Data(contentsOf: url) {
                                        self.saveImage(self.templateImageKey, imageData: imageData)
                                    }
                                }
                                else if let imageData = data as? Data {
                                    if (self.selectedColorName == "模板图片") {
                                        self.saveImage(self.templateImageKey, imageData: imageData)
                                    } else if (self.selectedColorName == "Red") {
                                    } else {
                                        // must be blue
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    // Builds a configuration item when we need it. This one is for the "Color"
    // configuration item.
    lazy var colorConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item?.title = "用作？"
        item?.value = self.selectedColorName
        item?.tapHandler = self.showColorSelection
        return item!
    }()
    
    // Shows a view controller when the user selects a configuration item
    func showColorSelection() {
        let controller = ColorSelectionViewController(style: .plain)
        controller.selectedColorName = colorConfigurationItem.value
        controller.delegate = self
        pushConfigurationViewController(controller)
    }
    
    // One the user selects a configuration item (color), we remember the value and pop
    // the color selection view controller
    func colorSelection(_ sender: ColorSelectionViewController, selectedValue: String) {
        colorConfigurationItem.value = selectedValue
        selectedColorName = selectedValue
        popConfigurationViewController()
    }
    
    // Saves an image to user defaults.
    func saveImage(_ color: String, imageData: Data) {
        if let prefs = UserDefaults(suiteName: suiteName) {
            prefs.removeObject(forKey: color)
            prefs.set(imageData, forKey: color)
        }
    }
}
