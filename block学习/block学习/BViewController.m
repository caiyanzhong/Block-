//
//  BViewController.m
//  block学习
//
//  Created by MacBook Air on 2018/5/17.
//  Copyright © 2018年 CYZ. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"界面B";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    if (self.block) {
        self.block(self.textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getValue:(ChangeBtbBlock)aBlock
{
    self.block = aBlock;
}


@end
