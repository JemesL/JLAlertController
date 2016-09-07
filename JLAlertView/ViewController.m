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
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"123"
                                                                   message:@"123"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    for (int i = 0 ; i < 1 ; i++) {
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  NSLog(@"123");
                                                              }];
        [alert addAction:defaultAction];

    }
    
//    alert.preferredAction = defaultAction2;
    
    [self presentViewController:alert animated:YES completion:nil];
    
//    JLAlertController *jlAlert = [JLAlertController alertControllerWithTitle:@"My Alert" message:@"This is an alert!" preferredStyle:JLAlertControllerStyleAlert];
//    [self presentViewController:jlAlert animated:YES completion:nil];


    
}

@end
