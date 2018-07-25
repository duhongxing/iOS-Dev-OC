//
//  CategoryViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "CategoryViewController.h"
#import "NSString+HXTestMethod.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //调用方法
    [@"Category" performSelector:@selector(hx_logTestCategory)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
