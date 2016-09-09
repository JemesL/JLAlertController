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
@property (nonatomic, strong) UIButton *cancelViewBtn;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) JLAlertAction *cancelAction;
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
//        self.backgroundColor = [UIColor whiteColor];
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
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 35 ;
        _layout.itemSize = CGSizeMake(width, 35);
    }
    return _layout;
}

#pragma mark -SetupContent
- (void)setupContent
{
    self.titleLabel.text = self.title;
    self.messageLabel.text = self.message;
    
//    [self layoutIfNeeded];
}

- (void)setActions:(NSArray<JLAlertAction *> *)actions
{
    _actions = actions;
    __block NSMutableArray *optionalAction = [[NSMutableArray alloc] init];
    [_actions enumerateObjectsUsingBlock:^(JLAlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        JLAlertAction *action = (JLAlertAction *)obj;
        if (action.style == JLAlertActionStyleCancel) {
            self.cancelAction = action;
        } else {
            [optionalAction addObject:action];
        }
    }];
    _actions = optionalAction.copy;
}

- (void)setCancelAction:(JLAlertAction *)cancelAction
{
    _cancelAction = cancelAction;
    [_cancelViewBtn setTitle:cancelAction.title forState:(UIControlStateNormal)];
}

#pragma mark -setupView
- (void)setupView
{
    [self layoutIfNeeded];
    [self setupActionColView];
    [self setupCancelView];
}

- (void)setupActionColView
{
    self.actionsColView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.actionsColView.layer.cornerRadius = 2;
    self.actionsColView.layer.masksToBounds = YES;
    self.actionsColView.backgroundColor = [UIColor whiteColor];
    [self.actionsColView registerClass:[JLAlertColViewCell class] forCellWithReuseIdentifier:JLAlertColViewCellIdentifier];
    self.actionsColView.delegate = self;
    self.actionsColView.dataSource = self;
    [self addSubview:self.actionsColView];
}

- (void)setupCancelView
{
    self.cancelView = [[UIView alloc] initWithFrame:CGRectZero];
    self.cancelView.layer.cornerRadius = 2;
    self.cancelView.layer.masksToBounds = YES;
    self.cancelView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.cancelView];
    
    self.cancelViewBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [self.cancelViewBtn setTitleColor:[UIColor colorAlertText] forState:(UIControlStateNormal)];
    self.cancelViewBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.cancelView addSubview:self.cancelViewBtn];
    [self.cancelViewBtn addTarget:self action:@selector(didTapOnCancelBtn:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)didTapOnCancelBtn:(id)sender
{
    self.ActionBlock(self.cancelAction);
}

- (void)layoutSubviews
{
    [self.actionsColView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(self.actionsColView.contentSize.height));
    }];
    
    [self.cancelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.actionsColView.mas_bottom).offset(10.0f);
        make.height.equalTo(@35);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [self.cancelViewBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cancelView);
    }];

    NSLog(@"%@",NSStringFromCGSize(self.actionsColView.contentSize));
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
    CGFloat margin = (self.preferredStyle == UIAlertControllerStyleAlert) ? 0 : 15;
    [cell setGrayLineWithMargin:margin hidden:(indexPath.item == 0)];
    return cell;
}

#pragma mark -UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.ActionBlock(self.actions[indexPath.item]);
}
@end
