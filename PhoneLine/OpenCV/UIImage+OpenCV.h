//
//  UIImage+OpenCV.h
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/24.
//

#ifndef UIImage_OpenCV_h
#define UIImage_OpenCV_h
#import <opencv2/opencv.hpp>
#import <UIKit/UIKit.h>

@interface UIImage (OpenCV)

    //cv::Mat to UIImage
+ (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat;
- (id)initWithCVMat:(const cv::Mat&)cvMat;

    //UIImage to cv::Mat
- (cv::Mat)CVMat;
- (cv::Mat)CVMat3;  // no alpha channel
- (cv::Mat)CVGrayscaleMat;

@end
#endif /* UIImage_OpenCV_h */
