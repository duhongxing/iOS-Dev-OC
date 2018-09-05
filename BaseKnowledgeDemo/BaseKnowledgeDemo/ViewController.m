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
    
    [self setupDataArray];
    [self setupTableView];
    
    
}

#pragma mark - 初始化数据

///初始化数据
- (void)setupDataArray
{
    _viewControllersArr = @[
                            @"RunLoopViewController",
                            @"KVCViewController",
                            @"KVOViewController",
                            @"PropertyViewController",
                            @"CategoryViewController",
                            @"ResponderViewController"
                            ];
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

#pragma mark - UITableViewDataSource

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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *className = _viewControllersArr[indexPath.row];
    Class VCClass =  NSClassFromString(className);
    
    id viewController = [[VCClass alloc]init];
    
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
