//
//  OpenCVWrapper.m
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/24.
//
#include <opencv2/opencv.hpp>
#import <opencv2/imgproc/types_c.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgcodecs/ios.h>
#include "OpenCVWrapper.h"

using namespace cv;
using namespace std;

@implementation OpenCVWrapper : NSObject

+ (UIImage *)processImageWithOpenCV:(UIImage*)inputImage mainColor:(UIColor*)inputColor {
    Mat mat;
    UIImageToMat(inputImage, mat);
    NSLog(@"%f :%f", inputImage.size.width,inputImage.size.height);
    NSLog(@"channel : %d",mat.channels());
    // do your processing here
    //cout<<mat.at<Vec4b>(0,0)<<endl;
    
    int cols = mat.cols;
    int rows = mat.rows;
    cout<<cols<<" : "<<rows<<endl;
    
    const CGFloat *components = CGColorGetComponents(inputColor.CGColor);
    
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (mat.at<Vec4b>(i,j)[0] == 0 && mat.at<Vec4b>(i,j)[1] == 0 && mat.at<Vec4b>(i,j)[2] == 0) {
                //NSLog(@"去除白色背景");
                mat.at<Vec4b>(i,j)[3] = 0;
            }else{
                mat.at<Vec4b>(i,j)[0] = components[0] * 255;
                mat.at<Vec4b>(i,j)[1] = components[1] * 255;
                mat.at<Vec4b>(i,j)[2] = components[2] * 255;
            }
        }
    }
    Mat dilateElement = getStructuringElement(MORPH_ELLIPSE, cv::Size(15, 15)); // 获得内核
    dilate(mat, mat, dilateElement); // 膨胀函数
    return MatToUIImage(mat);
}

@end
