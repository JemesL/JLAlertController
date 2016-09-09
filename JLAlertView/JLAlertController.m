//
//  JLAlertController.m
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertController.h"
#import "UIColor+Factory.h"
#import "Masonry.h"
#import "JLAlertView.h"
#import "JLSheetView.h"
@interface JLAlertAction()

@property (nonatomic, copy) void(^handler)(JLAlertAction *action);


@end
@implementation JLAlertAction

+ (instancetype)actionWithTitle:(NSString *)title style:(JLAlertActionStyle)style handler:(void (^)(JLAlertAction *))handler
{
    JLAlertAction *action = [[self alloc] initWithTitle:title style:style handler:handler];
    return action;
}

- (instancetype)initWithTitle:(NSString *)title style:(JLAlertActionStyle)style handler:(void (^)(JLAlertAction *))handler
{
    self = [super init];
    if (self) {
        _title = title;
        _style = style;
        _handler = handler;
    }
    return self;
}

@end


@interface JLAlertController()

@property (nonatomic, strong) UIView *darkBGView;

@property (nonatomic, strong) JLAlertView *alertView;
@property (nonatomic, strong) JLSheetView *sheetView;

@end
@implementation JLAlertController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JLAlertControllerStyle)preferredStyle
{
    JLAlertController *alertController = [[JLAlertController alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
    return alertController;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JLAlertControllerStyle)preferredStyle
{
    self = [super init];
    if (self) {
        self.title = title;
        self.message = message;
        _preferredStyle = preferredStyle;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        
        [self setupViews];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    switch (self.preferredStyle) {
        case JLAlertControllerStyleAlert:
            [self AlertAnimation];
            break;
        case JLAlertControllerStyleActionSheet:
            [self SheetAnimation];
            break;
        default:
            break;
    }
}

- (void)AlertAnimation
{
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.darkBGView.alpha = 0.3;
        self.alertView.alpha = 1;
        self.alertView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)SheetAnimation
{
//    [self.view layoutIfNeeded];
    [self.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17.5f);
        make.right.equalTo(self.view).offset(-17.5f);
        make.top.equalTo(self.view.mas_bottom);
    }];
    [self.view layoutIfNeeded];
    [self.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17.5f);
        make.right.equalTo(self.view).offset(-17.5f);
        make.top.equalTo(self.view.mas_bottom).offset(-1);
    }];
    [self.view layoutIfNeeded];
    [self.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17.5f);
        make.right.equalTo(self.view).offset(-17.5f);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10.0f);
    }];
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.darkBGView.alpha = 0.3;
        self.sheetView.alpha = 1;
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self dismissViewControllerAnimated:YES completion:nil];
//    });
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.darkBGView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.darkBGView];
    self.darkBGView.backgroundColor = [UIColor blackColor];
    self.darkBGView.userInteractionEnabled = YES;
    self.darkBGView.alpha = 0;
    
    switch (self.preferredStyle) {
        case JLAlertControllerStyleAlert:
            [self setupAlertView];
            break;
        case JLAlertControllerStyleActionSheet:
            [self setupSheetView];
            break;
        default:
            break;
    }
}

- (void)setupAlertView
{
    self.sheetView = nil;
    self.alertView = [[JLAlertView alloc] initWithFrame:CGRectZero title:self.title message:self.message];
    self.alertView.preferredStyle = self.preferredStyle;
    self.alertView.alpha = 0;
    self.alertView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    [self.view addSubview:self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@270);
        make.centerY.centerX.equalTo(self.view);
    }];
    
    __weak typeof(self) weakSelf = self;
    self.alertView.ActionBlock = ^(JLAlertAction *action){
        action.handler(action);
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)setupSheetView
{
    
    self.alertView = nil;
    self.sheetView = [[JLSheetView alloc] initWithFrame:CGRectZero title:self.title message:self.message];
    self.sheetView.preferredStyle = self.preferredStyle;
    self.sheetView.alpha = 1;
    [self.view addSubview:self.sheetView];
//    [self.sheetView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(17.5f);
//        make.right.equalTo(self.view).offset(-17.5f);
//        make.top.equalTo(self.view.mas_bottom);
//    }];
    __weak typeof(self) weakSelf = self;
    self.sheetView.ActionBlock = ^(JLAlertAction *action){
        action.handler(action);
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)addAction:(JLAlertAction *)action
{
    NSMutableArray *actionsArrM = [[NSMutableArray alloc] initWithArray:self.actions];
    [actionsArrM addObject:action];
    
    _actions = actionsArrM.copy;
    self.alertView.actions = _actions;
    self.sheetView.actions = _actions;
}

@end
