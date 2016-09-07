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
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
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

- (void)viewDidAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor blackColor];
    self.view.alpha = 0;
    self.view.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.alpha = 0.3;
    }];
}

- (void)setupViews
{
    self.alertBGView = [UIView alloc] initWithFrame:<#(CGRect)#>
}

@end
