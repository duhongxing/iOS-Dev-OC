//
//  BaseViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/12.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupConfig];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BaseSetup

- (void)setupConfig {
   
    CGFloat r = arc4random()%255;
    CGFloat g = arc4random()%255;
    CGFloat b = arc4random()%255;
   
    UIColor *randomColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    self.view.backgroundColor = randomColor;
    
    self.title = NSStringFromClass([self class]);
}


@end
