//
//  PropertyViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "PropertyViewController.h"

@interface PropertyViewController ()

@property (weak, nonatomic) id weakObjc;

@property (assign, nonatomic) id assignObjc;

@property (strong, nonatomic) id strongObjc;

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testWeak_AssignProperty];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///测试 weak 属性 和 assign 属性的区别
- (void)testWeak_AssignProperty {
    self.strongObjc = [NSDate date];
    //Wed Jul 25 17:51:18 2018
    NSLog(@"strong属性 %@",self.strongObjc);
    
    self.weakObjc = self.strongObjc;
    self.assignObjc = self.strongObjc;
    
    //置空
    self.strongObjc = nil;
    
    //weak 属性 (null)
    NSLog(@"weak 属性 %@",self.weakObjc);
    
    //EXC_BAD_ACCESS 野指针
    //    NSLog(@"assign 属性 %@",self.assignObjc);
}

@end
