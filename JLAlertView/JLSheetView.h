//
//  JLSheetView.h
//  JLAlertView
//
//  Created by Je.L on 9/8/16.
//  Copyright © 2016 JL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JLAlertAction;
@interface JLSheetView : UIView

@property (nonatomic, strong) NSArray<JLAlertAction *> *actions;
@property (nonatomic, copy) void (^ActionBlock)(JLAlertAction *action);

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title message:(NSString *)message;


@end
