//
//  BaseControllerUtils.m
//  Tbl
//
//  Created by Phil Hale on 06/05/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseControllerCommon.h"
#import "SVProgressHUD.h"

@interface BaseControllerCommon() <UIAlertViewDelegate>

@end

BOOL errorAlertVisible;

@implementation BaseControllerCommon

- (void)showError;
{
    [self hideSpinner];
    
    if(!errorAlertVisible)
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Sorry, an error has occurred while trying to retrieve the data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        errorAlertVisible = YES;
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    errorAlertVisible = NO;
}

- (void)showSpinner
{
    [SVProgressHUD show];
}

- (void)hideSpinner
{
    [SVProgressHUD dismiss];
}

- (void)toggleSpinner:(BOOL)isLoading
{
    if(isLoading) [self showSpinner];
    else [self hideSpinner];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

// TODO Test with rubbish internet connection
//    if(![Internet hasConnectivity])
//    {
//        //    // http://stackoverflow.com/questions/1083701/how-to-check-for-an-active-internet-connection-on-iphone-sdk
//        //    // http://stackoverflow.com/a/7934636/299048
//        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"No internet connection" message:@"Sorry, an internet connection is required for this app" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        //    
//        [alertView show];
//    }

@end
