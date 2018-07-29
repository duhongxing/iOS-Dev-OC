//
//  KVOViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/12.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "KVOViewController.h"

/** notification name */
static NSString  * kTestNotificationName = @"TestNotificationName";

@interface KVOViewController ()

@property (strong, nonatomic) UIButton *postBtn;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.postBtn];
    [self addNotification];
   
    
}

#pragma mark - event handle

- (void)notificationActionHandle:(NSNotification *)notificaiton {
    
    NSLog(@"userInfo:%@",notificaiton.userInfo);
    NSLog(@"name:%@",notificaiton.name);
    NSLog(@"object:%@",notificaiton.object);
    NSLog(@"%@",[NSThread currentThread]);
    NSLog(@"------------------------------------------------");
    
}

- (void)postInfoAction:(UIButton *)sender {
    //发送通知
    //1
    [[NSNotificationCenter defaultCenter]postNotificationName:kTestNotificationName object:@"讲真"];
    
    //2
    NSNotification *notification = [[NSNotification alloc]initWithName:kTestNotificationName object:@"😝" userInfo:@{@"name":@"baby"}];
    [[NSNotificationCenter defaultCenter]postNotification:notification];
    
    //全局队列发送通知
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //3
        [[NSNotificationCenter defaultCenter]postNotificationName:kTestNotificationName object:@"6666" userInfo:@{@"name":@"程序员"}];
    });
}

#pragma mark - 注册监听

- (void)addNotification {
    
    //1. 添加通知时 object != nil && object == 发送通知中的object 可以接受到通知
    //2. 添加通知时 object == nil  发送通知的object != nil 可以接受通知
    //3. 添加通知时 object == nil  发送通知的object == nil 可以接受通知
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationActionHandle:) name:kTestNotificationName object:nil];
}

#pragma mark - lazy load

- (UIButton *)postBtn {
    if (!_postBtn) {
        _postBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
        [_postBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_postBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_postBtn addTarget:self action:@selector(postInfoAction:) forControlEvents:UIControlEventTouchUpInside];
        _postBtn.backgroundColor = [UIColor whiteColor];
    }
    return _postBtn;
}


- (void)dealloc {
    
    //通知中心对响应者observer是使用unsafe_unretained修饰，当响应者释放会出现野指针，如果向野指针发送消息造成崩溃。
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
