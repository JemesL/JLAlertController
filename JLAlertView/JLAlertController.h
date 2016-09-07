//
//  JLAlertController.h
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import <UIKit/UIViewController.h>

typedef NS_ENUM(NSInteger, JLAlertActionStyle) {
    JLAlertActionStyleDefault = 0,
    JLAlertActionStyleCancel,
    JLAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, JLAlertControllerStyle) {
    JLAlertControllerStyleActionSheet = 0,
    JLAlertControllerStyleAlert
};


@interface JLAlertAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(NSString *)title style:(JLAlertActionStyle)style handler:(void (^)(JLAlertAction *action))handler;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) JLAlertActionStyle style;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end


@interface JLAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(JLAlertControllerStyle)preferredStyle;

- (void)addAction:(JLAlertAction *)action;

@property (nonatomic, readonly) NSArray<JLAlertAction *> *actions;
@property (nonatomic, strong) JLAlertAction *preferredAction;

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textFiled))configurationHandler;
@property (nonatomic, readonly) NSArray<UITextField *> *textFields;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, readonly) JLAlertControllerStyle preferredStyle;

@end
