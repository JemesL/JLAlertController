//
//  JLAlertView.m
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "JLAlertView.h"
#import "UIColor+Factory.h"
#import "Masonry.h"
@interface JLAlertView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UICollectionView *actionsColView;
@end

@implementation JLAlertView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorAlertBG];
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message
{
    self = [self initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    [self setupContentScrollView];
    [self setupActionColView];
}

- (void)setupContentScrollView
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentScrollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self.contentScrollView addSubview:self.titleLabel];
    [self.contentScrollView addSubview:self.messageLabel];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentScrollView).offset(16.0f);
        make.right.equalTo(self.contentScrollView).offset(-16.0f);
        make.top.equalTo(self.contentScrollView).offset(20.0f);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7.0f);
        make.left.right.bottom.equalTo(self.contentScrollView);
    }];
    
}

- (void)setupActionColView
{
//    self.actionsColView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:nil];
//    [self addSubview:self.contentScrollView];
//    [self.actionsColView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.
//    }];
    
}
@end
