//
//  ViewController.m
//  JLAlertView
//
//  Created by JL on 16/9/7.
//  Copyright © 2016年 JL. All rights reserved.
//

#import "ViewController.h"
#import "JLAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor orangeColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"This is my honey!"
                                                                   message:@"哈哈哈哈"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0 ; i < 2 ; i++) {
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  NSLog(@"123");
                                                              }];
        [alert addAction:defaultAction];

    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
    JLAlertController *jlAlert = [JLAlertController alertControllerWithTitle:@"Hello!" message:@"." preferredStyle:JLAlertControllerStyleAlert];
    
    JLAlertAction *action = [JLAlertAction actionWithTitle:@"OK" style:JLAlertActionStyleDefault handler:^(JLAlertAction *action) {
        [self didTapOnOKBTN];
    }];
    [jlAlert addAction:action];
    
    JLAlertAction *action2 = [JLAlertAction actionWithTitle:@"OK" style:JLAlertActionStyleDefault handler:^(JLAlertAction *action) {
        [self didTapOnOKBTN2];
    }];
    [jlAlert addAction:action2];

//    JLAlertAction *action3 = [JLAlertAction actionWithTitle:@"OK" style:JLAlertActionStyleDefault handler:^(JLAlertAction *action) {
//        [self didTapOnOKBTN];
//    }];
//    [jlAlert addAction:action3];
    
    [self presentViewController:jlAlert animated:YES completion:nil];
}

- (void)didTapOnOKBTN
{
    NSLog(@"didTapOnOKBTN");
}

- (void)didTapOnOKBTN2
{
    NSLog(@"didTapOnOKBTN222222");
}

@end
