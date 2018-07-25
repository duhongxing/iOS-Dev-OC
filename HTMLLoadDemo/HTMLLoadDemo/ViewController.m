//
//  ViewController.m
//  HTMLLoadDemo
//
//  Created by 杜红星 on 2018/7/25.
//  Copyright © 2018年 dhx. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()

@property (strong, nonatomic) UILabel *htmlLab;

@property (strong, nonatomic) UITextView *htmlText;

@property (strong, nonatomic) UIWebView *htmlUIWebView;

@property (strong, nonatomic) WKWebView *htmlWKWebiew;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *html = @"<div><div><p>sublime text</p></div><div><p> sublime text </p></div><div><p> sublime text </p></div></div>";
    
    NSAttributedString *attribute = [[NSAttributedString alloc]initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//    CGSize size = [self.htmlLab sizeThatFits:CGSizeMake(300, 1000)];
    self.htmlLab.attributedText = attribute;
    self.htmlLab.frame = CGRectMake(0, 0, 240, 100);
    [self.view addSubview:self.htmlLab];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadHTMLUseLabel {
    
}

#pragma mark - lazyload

- (UILabel *)htmlLab {
    if (!_htmlLab) {
        _htmlLab = [UILabel new];
        _htmlLab.font = [UIFont systemFontOfSize:14];
        _htmlLab.textColor = [UIColor blueColor];
    }
    return _htmlLab;
}

- (UITextView *)htmlText {
    if (!_htmlText) {
        _htmlText = [UITextView new];
    }
    return _htmlText;
}

@end
