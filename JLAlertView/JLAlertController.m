//
//  JLAlertController.m
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertController.h"
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
@property (nonatomic, strong) UIView *alertBGView;
@property (nonatomic, strong) UIView *darkBGView;
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

- (void)addAction:(JLAlertAction *)action
{
    NSMutableArray *actionsArrM = [[NSMutableArray alloc] initWithArray:self.actions];
    [actionsArrM addObject:action];
    
    _actions = actionsArrM.copy;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    self.view.alpha = 0;
//    self.view.userInteractionEnabled = YES;

    [UIView animateWithDuration:0.25 animations:^{
        self.darkBGView.alpha = 0.3;
    }];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor clearColor];
    
    self.darkBGView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.darkBGView];
    self.darkBGView.backgroundColor = [UIColor blackColor];
    self.darkBGView.alpha = 0;
    
    self.alertBGView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
