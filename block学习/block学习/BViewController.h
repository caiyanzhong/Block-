//
//  BViewController.h
//  block学习
//
//  Created by MacBook Air on 2018/5/17.
//  Copyright © 2018年 CYZ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeBtbBlock)(NSString *text);
@interface BViewController : UIViewController
@property (nonatomic, copy) ChangeBtbBlock block;

- (void)getValue:(ChangeBtbBlock)aBlock;

@end
