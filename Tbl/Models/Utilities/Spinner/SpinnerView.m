//
//  SpinnerView.m
//  Tbl
//
//  Created by Phil Hale on 06/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView
+ (UIView*)getBasicSpinnerForView:(UIView*)view
{
    UIView *spinnerView = [[UIView alloc] initWithFrame:view.bounds];
    // I'm pretty sure the starting position must be 0, 0
    //spinnerView.frame = CGRectMake(0.0, 0.0, view.bounds.size.width, view.bounds.size.height);
    //spinnerView.backgroundColor = [UIColor blueColor];
    spinnerView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.7];
//    spinnerView.alpha = 1.0;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    // TODO Centering doesn't work
    //    CGRect frame = self.spinner.frame;
    //    frame.origin.x = self.view.frame.size.width / 2 - frame.size.width / 2;
    //    frame.origin.y = self.view.frame.size.height / 2 - frame.size.height / 2;
    //    self.spinner.frame = frame;
    
    // Center is set in the superviews coordinate system
    //spinnerView.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
    //spinnerView.center = view.center;
        
    //spinnerView.center = view.center;
    [spinnerView addSubview:spinner];
    spinner.center = spinnerView.center;
    //spinner.center = CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2);

    
    
    [spinner startAnimating];
    
    return spinnerView;
}
@end
