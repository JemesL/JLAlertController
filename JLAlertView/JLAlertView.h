//
//  JLAlertView.h
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLAlertController.h"
@interface JLAlertView : UIView

@property (nonatomic, strong) NSArray<JLAlertAction *> *actions;
@property (nonatomic, copy) void (^ActionBlock)(JLAlertAction *action);
@property (nonatomic) JLAlertControllerStyle preferredStyle;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;

@end
