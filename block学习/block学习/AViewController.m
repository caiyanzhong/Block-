//
//  ViewController.m
//  block学习
//
//  Created by MacBook Air on 2018/5/17.
//  Copyright © 2018年 CYZ. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"

@interface AViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     ARC情况下
     1.如果用copy修饰Block，该Block就会存储在堆空间。则会对Block的内部对象进行强引用，导致循环引用。内存无法释放。
     解决方法：
     新建一个指针(__weak typeof(Target) weakTarget = Target )指向Block代码块里的对象，然后用weakTarget进行操作。就可以解决循环引用问题。
     
     
     如果用weak修饰Block，该Block就会存放在栈空间。不会出现循环引用问题。
     MRC情况下
     用copy修饰后，如果要在Block内部使用对象，则需要进行(__block typeof(Target) blockTarget = Target )处理。在Block里面用blockTarget进行操作。
     
     Block的定义格式
     
     返回值类型(^block变量名)(形参列表) = ^(形参列表) {
     };
     调用Block保存的代码
     block变量名(实参);
     
     默认情况下,Block内部不能修改外面的局部变量
     Block内部可以修改使用__block修饰的局部变量
     */
    
    //实现一个block 这个block实现代码是在栈区的，也就是说，当viewDidLoad这个方法执行完之后，block就消失了。
    void(^block)(void) = ^{
        NSLog(@"block的简单使用");
    };
    
    
    //赋值给属性_block 此时就完成了copy _block指针指向堆中一块内存(存放的是block的实现代码)，_block就一直拥有了代码块的使用权，直到ViewController对象消亡。
    self.block = block;
    self.block();
    
    
    
    int a = 10;//a对于_block来说就是一个外部变量
    self.block = ^{
        NSLog(@"a = %d", a);//但是，此时是可以使用a的
    };
    self.block();

    
    //如果要在block内修改block外声明的栈变量，那么一定要对该变量加__block标记
    __block int b = 10;//用__block修饰之后，系统会传递a的地址(&a)
    self.block = ^{
        b += 20;
        NSLog(@"b = %d",b);//有地址，当然就可以修改a的值了。此时a的值是30
    };
    self.block();

    
    
    UIView *view = [[UIView alloc] init];
    __weak typeof(view)_view = view;//_view和view指向同一块内存，而_view是弱引用,view的retainCount还是1.
    self.block = ^{
        //view.frame = CGRectMake(0, 0, 100, 100);//在block内部使用view对象，系统会对view强引用，此时会造成内存泄漏。
        _view.frame = CGRectMake(100, 100, 100, 100);
        _view.backgroundColor = [UIColor redColor];
    };
    self.block();
    
    NSString* (^logBlock)(NSString *,NSString *) = ^(NSString * str1,NSString *str2){
        return [NSString stringWithFormat:@"%@%@",str1,str2];
    };
    //调用logBlock,输出的是 我是Block
    NSLog(@"%@", logBlock(@"我是",@"Block"));
    
    self.title = @"界面A";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonClick:(id)sender {
    BViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"BViewController"];
    //使用弱引用防止 循环引用
    __weak AViewController *weakSelf = self;
    vc.block = ^(NSString *text) {
        weakSelf.button.titleLabel.text = text;
//        self.button.titleLabel.text = text;
    };
    
    [vc getValue:^(NSString *text) {
        weakSelf.button.titleLabel.text = text;
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
