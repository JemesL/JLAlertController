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
#import "JLAlertColViewCell.h"
#import "JLAlertController.h"
@interface JLAlertView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UICollectionView *actionsColView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutWithTwoProject;
@end

@implementation JLAlertView

static NSString *JLAlertColViewCellIdentifier = @"JLAlertColViewCell";

#pragma mark -init
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

- (UICollectionViewFlowLayout *)layoutWithTwoProject
{
    if (_layoutWithTwoProject == nil) {
        _layoutWithTwoProject = [[UICollectionViewFlowLayout alloc] init];
        _layoutWithTwoProject.minimumLineSpacing = 0.0f;
        _layoutWithTwoProject.minimumInteritemSpacing = 0.0f;
        _layoutWithTwoProject.itemSize = CGSizeMake(135, 35);
    }
    return _layoutWithTwoProject;
}

#pragma mark -SetupContent
- (void)setupContent
{
    self.titleLabel.text = self.title;
    self.messageLabel.text = self.message;
    
    [self.contentScrollView layoutIfNeeded];
}

- (void)setActions:(NSArray<JLAlertAction *> *)actions
{
    _actions = actions;
    
    if (_actions.count == 2) {
        self.actionsColView.collectionViewLayout = self.layoutWithTwoProject;
    } else {
        self.actionsColView.collectionViewLayout = self.layout;
    }
    
}

#pragma mark -SetupView
- (void)setupView
{
    [self layoutIfNeeded];
    [self setupContentScrollView];
    [self setupActionColView];
}

- (void)setupContentScrollView
{
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentScrollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor colorAlertText];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.textColor = [UIColor colorAlertText];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    
    [self.contentScrollView addSubview:self.titleLabel];
    [self.contentScrollView addSubview:self.messageLabel];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
//    line.backgroundColor = [UIColor colorGrayLine];
//    [self addSubview:line];
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@1);
//        make.left.right.equalTo(self);
//        make.bottom.equalTo(self.contentScrollView);
//    }];
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

- (void)layoutSubviews
{
    if (self.title) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentScrollView).offset(20.0f);
            make.left.equalTo(self.contentScrollView).offset(16.0f);
            make.centerX.equalTo(self.contentScrollView);
            self.message ? nil : make.bottom.equalTo(self.contentScrollView).offset(-20.0f);
        }];
    }
    
    if (self.message) {
        [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            self.title ? make.top.equalTo(self.titleLabel.mas_bottom).offset(7.0f) : make.top.equalTo(self.contentScrollView).offset(20.0f);;
            make.left.equalTo(self.contentScrollView).offset(16.0f);
            make.centerX.equalTo(self.contentScrollView);
            make.bottom.equalTo(self.contentScrollView.mas_bottom).offset(-20);
        }];
    }
    
    [self.contentScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(self.contentScrollView.contentSize.height));
    }];
    
    [self.actionsColView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentScrollView.mas_bottom);
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(self.actionsColView.contentSize.height));
    }];
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.actions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JLAlertColViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:JLAlertColViewCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[JLAlertColViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.title.text = [self.actions[indexPath.item] title];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.ActionBlock(self.actions[indexPath.item]);
}




@end
