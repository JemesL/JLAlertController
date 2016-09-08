//
//  JLSheetView.m
//  JLAlertView
//
//  Created by Je.L on 9/8/16.
//  Copyright © 2016 JL. All rights reserved.
//

#import "JLSheetView.h"
#import "UIColor+Factory.h"
#import "Masonry.h"
#import "JLAlertController.h"
#import "JLAlertColViewCell.h"
@interface JLSheetView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UICollectionView *actionsColView;
@property (nonatomic, strong) UIView *cancelView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end
@implementation JLSheetView

static NSString *JLAlertColViewCellIdentifier = @"JLAlertColViewCell";

#pragma mark -init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message
{
    self = [self initWithFrame:frame];
    if (self) {
        self.title = title;
        self.message = message;
        [self setupView];
        [self setupContent];
    }
    return self;
}

#pragma mark -lazy
- (UICollectionViewFlowLayout *)layout
{
    if (_layout == nil) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumLineSpacing = 0.0f;
        _layout.minimumInteritemSpacing = 0.0f;
        _layout.itemSize = CGSizeMake(270, 35);
    }
    return _layout;
}

#pragma mark -setupView
- (void)setupView
{
//    [self setupContentScrollView];
    [self setupActionColView];
    [self setupCancelView];
}

- (void)setupActionColView
{
    self.actionsColView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.actionsColView.backgroundColor = [UIColor whiteColor];
    [self.actionsColView registerClass:[JLAlertColViewCell class] forCellWithReuseIdentifier:JLAlertColViewCellIdentifier];
    self.actionsColView.delegate = self;
    self.actionsColView.dataSource = self;
    [self addSubview:self.actionsColView];
}

- (void)setupCancelView
{
    
}

- (void)setupContent
{
    
}

@end
