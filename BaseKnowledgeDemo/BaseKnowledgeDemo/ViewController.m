//
//  ViewController.m
//  BaseKnowledgeDemo
//
//  Created by 杜红星 on 2018/7/11.
//  Copyright © 2018年 MrDu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *tableView;

@end

@implementation ViewController
{
    NSArray *_viewControllersArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _viewControllersArr = [NSArray arrayWithObjects:@"RunLoopViewController",@"DHXKVCViewController", nil];
    [self setupTableView];
}

#pragma mark - UI

///初始化列表
- (void)setupTableView {
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.rowHeight = 50;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDelegate or  UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewControllersArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifer = @"identifierCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.textLabel.text = _viewControllersArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = _viewControllersArr[indexPath.row];
    Class VCClass =  NSClassFromString(className);
    
    id viewController = [[VCClass alloc]init];
    
    [self presentViewController:viewController animated:YES completion:nil];
}



@end
