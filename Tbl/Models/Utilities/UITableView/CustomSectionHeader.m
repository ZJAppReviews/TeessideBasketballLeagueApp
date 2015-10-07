//
//  CustomSectionHeader.m
//  Tbl
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "CustomSectionHeader.h"

// Code take from http://stackoverflow.com/questions/2898361/how-to-recreate-the-default-uiview-the-same-as-the-default-tableviewviewforhead
@implementation CustomSectionHeader
+ (UIView*)mimicDefaultSectionHeaderView
{
    UIImage *buttonImageNormal = [UIImage imageNamed:@"section_header_background_light_grey.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    // Create the view for the header
    CGRect sectionFrame = CGRectMake(0.0, 0.0, 320.0, 22.0);
    UIView *sectionView = [[UIView alloc] initWithFrame:sectionFrame];
    sectionView.alpha = 0.9;
    sectionView.backgroundColor = [UIColor colorWithPatternImage:stretchableButtonImageNormal];
    
    return sectionView;
}

+ (UILabel*)mimicDefaultSectionHeaderLabel:(CGFloat)x y:(CGFloat)y width:(CGFloat)width text:(NSString*)text
{
    CGRect labelFrame = CGRectMake(x, y, width, 22.0);
    UILabel *sectionLabel = [[UILabel alloc] initWithFrame:labelFrame];
    sectionLabel.text = text;
    sectionLabel.font = [UIFont boldSystemFontOfSize:18.0];
    sectionLabel.textColor = [UIColor whiteColor];
    sectionLabel.shadowColor = [UIColor grayColor];
    sectionLabel.shadowOffset = CGSizeMake(0, 1);
    sectionLabel.backgroundColor = [UIColor clearColor];
    
    return sectionLabel;
}

+ (UIView*)mimicDefaultSectionHeaderViewWithDoubleHeight
{
    UIImage *buttonImageNormal = [UIImage imageNamed:@"section_header_background_double_height_light_grey.png"];
    UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    // Create the view for the header
    CGRect sectionFrame = CGRectMake(0.0, 0.0, 320.0, 44.0);
    UIView *sectionView = [[UIView alloc] initWithFrame:sectionFrame];
    sectionView.alpha = 0.9;
    sectionView.backgroundColor = [UIColor colorWithPatternImage:stretchableButtonImageNormal];
    
    return sectionView;
}
@end
