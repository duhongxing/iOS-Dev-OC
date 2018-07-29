//
//  ResponderViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/27.
//  Copyright © 2018年 MrDu. All rights reserved.
//


#import "ResponderViewController.h"
#import "HXResponderView.h"

@interface ResponderViewController ()<UIGestureRecognizerDelegate>


@end

@implementation ResponderViewController
{
    HXResponderView *_view1;
    HXResponderView *_view2;
    HXResponderView *_view3;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"%@",self.view.nextResponder);
   

    [self createSubViews];
    
    
}

///创建测试视图
- (void)createSubViews {
    _view1 = [[HXResponderView alloc]initWithFrame:CGRectMake(100, 100, 150, 100)];
    _view1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view1];
    
    _view2 = [[HXResponderView alloc]initWithFrame:CGRectMake(100, 280, 150, 100)];
    _view2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_view2];
    
    _view3 = [[HXResponderView alloc]initWithFrame:CGRectMake(20, 25, 160, 160)];
    _view3.backgroundColor = [UIColor redColor];
    [_view1 addSubview:_view3];
}

///UIControl target-action
- (void)controlTest {
    
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    control.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:control];
    
    [control addTarget:self action:@selector(actionHandle:) forControlEvents:UIControlEventAllEvents];
}

#pragma mark - gestureDelegate

///要让手势向下传递，只需要实现手势识别器如下代理方法：
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - event responder

- (void)actionHandle:(UIControl *)control {
    control.backgroundColor = [UIColor redColor];
}





@end
