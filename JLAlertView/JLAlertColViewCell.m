//
//  JLAlertColViewCell.m
//  JLAlertView
//
//  Created by JL on 9/8/16.
//  Copyright © 2016 JL. All rights reserved.
//

#import "JLAlertColViewCell.h"
#import "Masonry.h"
#import "UIColor+Factory.h"


@interface JLAlertColViewCell()
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *topGrayLine;
@end
@implementation JLAlertColViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.grayView = [[UIView alloc] initWithFrame:CGRectZero];
    self.grayView.backgroundColor = [UIColor colorGrayLine];
    [self addSubview:self.grayView];
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.grayView.alpha = 0;
    
    self.title = [[UILabel alloc] initWithFrame:CGRectZero];
    self.title.backgroundColor = [UIColor clearColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.textColor = [UIColor colorAlertText];
    self.title.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *topGrayLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.topGrayLine = topGrayLine;
    topGrayLine.backgroundColor = [UIColor colorGrayLine];
    [self addSubview:topGrayLine];
    [topGrayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@1.0);
    }];
    
    UIView *VLine = [[UIView alloc] initWithFrame:CGRectZero];
    VLine.backgroundColor = [UIColor colorGrayLine];
    [self addSubview:VLine];
    [VLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(-1.0f);
        make.width.equalTo(@1);
        make.top.equalTo(self).offset(4.0f);
        make.bottom.equalTo(self).offset(-4.0f);
    }];
}

- (void)setGrayLineWithMargin:(CGFloat)margin hidden:(BOOL)isHidden
{
    self.topGrayLine.hidden = isHidden;
    [self.topGrayLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self).offset(-margin);

        make.height.equalTo(@1.0);
    }];

}

@end
