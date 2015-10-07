//
//  CustomSectionHeader.h
//  Tbl
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSectionHeader : NSObject
// Both methds currently default to 22 height. May have to change in the future
// This image is required - sectionheaderbackground.png
+ (UIView*)mimicDefaultSectionHeaderView;
+ (UILabel*)mimicDefaultSectionHeaderLabel:(CGFloat)x y:(CGFloat)y width:(CGFloat)width text:(NSString*)text;

+ (UIView*)mimicDefaultSectionHeaderViewWithDoubleHeight;

@end
