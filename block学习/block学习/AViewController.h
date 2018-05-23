//
//  ViewController.h
//  block学习
//
//  Created by MacBook Air on 2018/5/17.
//  Copyright © 2018年 CYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(void);

@interface AViewController : UIViewController
@property (nonatomic, copy) MyBlock block;

@end

