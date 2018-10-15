//
//  JZActivityPopView.m
//  Jiazheng
//
//  Created by 杜 on 2018/8/16.
//  Copyright © 2018年 58. All rights reserved.
//

#import "DJActivityPopView.h"

#define kXScreen_width  CGRectGetWidth([UIScreen mainScreen].bounds)
#define kXScreen_height CGRectGetHeight([UIScreen mainScreen].bounds)

@interface DJActivityPopView ()

/** 蒙版 */
@property (nonatomic, strong) UIView *maskView;

/** 容器视图 */
@property (nonatomic, strong) UIView *containerView;

/** 背景视图 */
@property (nonatomic, strong) UIImageView *backgroundImgV;

/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeBtn;

/** 活动图片 */
@property (nonatomic, strong) UIImage *activityImg;

/** 活动链接 */
@property (nonatomic, copy) NSString *activityUrl;

/** 弹框覆盖的控制器 */
@property (nonatomic, weak) UIViewController *viewController;

@end

@implementation DJActivityPopView

- (instancetype)initWithActivityImg:(UIImage *)image activityUrl:(NSString *)url fromViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        //根据图片的宽高比例计算弹框高度
        CGFloat imageWidth  = image.size.width;
        CGFloat imageHeight = image.size.height;
        CGFloat activityTotalHeight = (kXScreen_width - 80)/imageWidth * imageHeight + 70;
        self.frame = CGRectMake(40, 101,kXScreen_width - 80, activityTotalHeight);
        self.backgroundColor = [UIColor clearColor];
        _activityImg = image;
        _activityUrl = url;
        _viewController = viewController;
        [self setupSubViews];
        [self addRecognizer];
    }
    return self;
}

- (instancetype)initWithActivityImg:(UIImage *)image activityUrl:(NSString *)url {
    DJActivityPopView *instance = [[DJActivityPopView alloc]initWithActivityImg:image activityUrl:url fromViewController:nil];
    return instance;
}

#pragma mark -  初始化视图

///初始化视图
- (void)setupSubViews {
    
     __weak typeof(self) weakSelf = self;
    
    _containerView  = [UIView new];
    _backgroundImgV = [UIImageView new];
    _closeBtn       = [UIButton new];
    [self addSubview:_containerView];
    [self addSubview:_closeBtn];
    [_containerView addSubview:_backgroundImgV];
    
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
   
    [_backgroundImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf.containerView);
        make.bottom.equalTo(weakSelf.containerView).offset(-70);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.height.equalTo(@40);
    }];
    
    _backgroundImgV.userInteractionEnabled = YES;
    _backgroundImgV.image = self.activityImg;
    
    //关闭按钮
    [_closeBtn setImage:[UIImage imageNamed:@"activity_close_normal"] forState:UIControlStateNormal];
    [_closeBtn setImage:[UIImage imageNamed:@"activity_close_hight"] forState:UIControlStateHighlighted];
    [_closeBtn addTarget:self action:@selector(closeActivityViewAction:) forControlEvents:UIControlEventTouchUpInside];
}

///添加手势
- (void)addRecognizer {
    
    //蒙版添加移除视图手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionHandle:)];
    [self.maskView addGestureRecognizer:tapGesture];
    
    //容器视图添加移除视图手势
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapActionHandle:)];
    [self.containerView addGestureRecognizer:tapGesture2];
    
    //跳转点击手势
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpActionHandle:)];
    [self.backgroundImgV addGestureRecognizer:tapGesture3];
}

#pragma mark - event response

- (void)tapActionHandle:(UITapGestureRecognizer *)tap {
    //移除弹窗
    [self hideWithCompletion:nil];
    if (self.actionBlock) {
        self.actionBlock(DJActionTypeTapMask);
    }
}

- (void)jumpActionHandle:(UITapGestureRecognizer *)tap {
    //移除弹窗
    [self hideWithCompletion:nil];
    if (self.actionBlock) {
        self.actionBlock(DJActionTypeJump);
    }
}

- (void)closeActivityViewAction:(UIButton *)sender {
    //移除弹窗
    [self hideWithCompletion:nil];
    if (self.actionBlock) {
        self.actionBlock(DJActionTypeClose);
    }
}

#pragma mark - setter

- (void)setDismissWhenTapMask:(BOOL)dismissWhenTapMask {
    _dismissWhenTapMask = dismissWhenTapMask;
    if (_dismissWhenTapMask) {
        self.maskView.userInteractionEnabled = YES;
    } else {
        self.maskView.userInteractionEnabled = NO;
    }
}

- (void)setCloseBtnPosition:(DJPopViewCloseBtnPosition)closeBtnPosition {
    _closeBtnPosition = closeBtnPosition;
    [self resetClosePositionWithPosition:_closeBtnPosition];
}

#pragma mark - private Method

//显示动画
- (void)addShowAnimationWithCompletion:(void(^)(void))completion{
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.0 ;
    } completion:^(BOOL finished) {
        self.opaque = NO ;
        if (completion) {
            completion();
        }
    }];
}

//关闭动画
- (void)addHideAnimationWithCompletion:(void(^)(void))completion{
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform      = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha          = 0.0 ;
        self.maskView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    }];
}


/**
 重设关闭按钮位置

 @param position 位置
 */
- (void)resetClosePositionWithPosition:(DJPopViewCloseBtnPosition)position {
    switch (position) {
        case DJPopViewCloseBtnPositionTop:
        {
            [self setCloseBtnTop];//顶部
        }
            break;
            
        case DJPopViewCloseBtnPositionBottom:
        {
            [self setCloseBtnBottom];//底部
        }
            break;
            
        case DJPopViewCloseBtnPositionLeft:
        {
            [self setCloseBtnLeft];//左上
        }
            break;
            
        case DJPopViewCloseBtnPositionRight:
        {
            [self setCloseBtnRight];//右上
        }
            break;
            
        default:
            break;
    }
}

///设置关闭按钮在顶部
- (void)setCloseBtnTop {
    __weak typeof(self) weakSelf = self;
    [_backgroundImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(70);
    }];
    
    [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.height.equalTo(@40);
    }];
}

///设置关闭按钮在底部
- (void)setCloseBtnBottom {
    __weak typeof(self) weakSelf = self;
    [_backgroundImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(weakSelf.containerView);
        make.bottom.equalTo(weakSelf.containerView).offset(-70);
    }];
    
    [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.width.height.equalTo(@40);
    }];
}

///设置关闭按钮在左上角
- (void)setCloseBtnLeft {
    __weak typeof(self) weakSelf = self;
    [_backgroundImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(70);
    }];
    
    [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.height.equalTo(@40);
    }];

}

///设置关闭按钮在右上角
- (void)setCloseBtnRight {
    __weak typeof(self) weakSelf = self;
    [_backgroundImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(70);
    }];
    
    [_closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.width.height.equalTo(@40);
    }];

}

#pragma mark - public Method

- (void)showWithCompletion:(void(^)(void))completion {
    
    if (!self.activityImg || !self.activityUrl) { //没获取到活动图片 或 没有活动跳转链接
        return;
    }
    
    UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
    [keyWindow addSubview:self.maskView];
    [keyWindow addSubview:self];
    [self addShowAnimationWithCompletion:completion];
    self.center = keyWindow.center;
    
}

- (void)hideWithCompletion:(void(^)(void))completion {
    [self addHideAnimationWithCompletion:completion];
}

#pragma mark - lazy load

- (UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
        _maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    }
    return _maskView;
}


@end
