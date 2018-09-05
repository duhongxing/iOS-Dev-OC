//
//  ViewController.m
//  HXiPhoneXAdapterDemo
//
//  Created by 杜红星 on 2018/7/29.
//  Copyright © 2018年 dhx. All rights reserved.
//

#import "ViewController.h"

//https://juejin.im/post/5a4b04276fb9a045240630cc

@interface ViewController ()

@property (strong, nonatomic) UIScrollView *scroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.scroll.contentInset = UIEdgeInsetsMake(100, 0, -34, 10);
    if (@available(iOS 11.0, *)) {
        self.scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
