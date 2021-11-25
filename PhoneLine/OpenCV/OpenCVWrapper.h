//
//  OpenCVWrapper.h
//  PhoneLine
//
//  Created by Mini-M14Marshaii on 2021/11/24.
//

#ifndef OpenCVWrapper_h
#define OpenCVWrapper_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OpenCVWrapper : NSObject

    + (UIImage *)processImageWithOpenCV:(UIImage*)inputImage mainColor:(UIColor*)inputColor;

@end

#endif /* OpenCVWrapper_h */
