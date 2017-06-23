//
//  ViewController.m
//  UIAlertController练习
//
//  Created by hzc on 2017/6/23.
//  Copyright © 2017年 hzc. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}

// 查看所有的成员变量
- (void)getAllIvars:(id)obj {
    
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([obj class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"%s ----%@",name,[obj class]);
    }
    free(ivars);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *title = @"提示";
    NSString *message = @"\n我是内容\n我是内容\n我是内容\n我是内容";
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cancelAction];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:confirmAction];
    
    // 自定义按钮(对齐方式、颜色、图片)
    [cancelAction setValue:[NSNumber numberWithInteger:NSTextAlignmentLeft] forKey:@"titleTextAlignment"];
    [cancelAction setValue:[[UIImage imageNamed:@"atm"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"_image"];
    [confirmAction setValue:[UIColor orangeColor] forKey:@"_titleTextColor"];
    [confirmAction setValue:[[UIImage imageNamed:@"atm"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"_image"];
    
    
    // 自定义标题（颜色、字体）
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, title.length)];
    [titleAttri addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, title.length)];
    [alertVc setValue:titleAttri forKey:@"_attributedTitle"];
    
    // 自定义内容（颜色、字体、对齐方式）
    NSMutableAttributedString *messageAttri = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAttri addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, message.length)];
    [messageAttri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, message.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 5.0;
    [messageAttri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, message.length)];
    [alertVc setValue:messageAttri forKey:@"_attributedMessage"];
//    [alertVc setValue:messageAttri forKey:@"_attributedDetailMessage"]; // 这个看起来没什么卵用
    
    // 可以添加一个textField (只能给样式为alert的添加，actionSheet不行！)
    [alertVc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
       // 在这里可以配置textField的样式
        textField.placeholder = @"请输入六位密码";
        textField.textColor = [UIColor blueColor];
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    
    // 同样可以在里面放图片
//    UIAlertController *alertVc1 = [UIAlertController alertControllerWithTitle:@"\n\n\n\n" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alertVc1 addAction:cancelAction1];
//    
//    UIAlertAction *confirmAction1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alertVc1 addAction:confirmAction1];
//    
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = CGRectMake(10, 10, 50, 50);
//    imageView.image = [UIImage imageNamed:@"Smile"];
//    [alertVc1.view addSubview:imageView];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
    // 分别查看UIAlertController和UIAlertAction的成员变量
    [self getAllIvars:alertVc];
    [self getAllIvars:confirmAction];
    
}



@end
