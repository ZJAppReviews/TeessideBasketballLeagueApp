//
//  BaseController.m
//  Tbl
//
//  Created by Phil Hale on 04/04/2012.
//  Copyright (c) 2012 Phil Hale. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseControllerCommon.h"

@interface BaseViewController()
@property (nonatomic, strong) BaseControllerCommon *common;
@property (nonatomic, readwrite, strong) TblDataServiceHelper *tblDataService;
@end

@implementation BaseViewController

@synthesize common = _common;
@synthesize tblDataService = _tblDataService;
@synthesize isLoading = _isLoading;

- (BaseControllerCommon*)common
{
    if(!_common)
        _common = [[BaseControllerCommon alloc] init];
    
    return _common;
}

- (TblDataServiceHelper*)tblDataService
{
    if(!_tblDataService) 
    {
        _tblDataService = [[TblDataServiceHelper alloc] initWithErrorTarget:self errorAction:@selector(showWebServiceError)];
    }
    
    return _tblDataService;
}

- (void)setIsLoading:(BOOL)isLoading
{
    _isLoading = isLoading;
    [self.common toggleSpinner:isLoading];
}

#pragma mark - Helper methods
- (void)showWebServiceError
{
    [self.common showError];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.common = nil;
    self.tblDataService = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.common toggleSpinner:self.isLoading];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.common shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

@end
