//
//  BaseViewController.m
//  HXiPhoneXAdapterDemo
//
//  Created by 杜红星 on 2018/8/16.
//  Copyright © 2018年 dhx. All rights reserved.
//

#import "BaseViewController.h"
#import "iPhoneXAdapter.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupSafeArea {
    if (IS_IPHONE_X) {
        self.safeAreaView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - BOTTOM_SAFEAREA_HEIGHT, SCREEN_WIDTH, BOTTOM_SAFEAREA_HEIGHT)];
    }
}


@end
