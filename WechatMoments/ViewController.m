//
//  ViewController.m
//  WechatMoments
//
//  Created by chen guo on 2018/11/8.
//  Copyright © 2018年 chen guo. All rights reserved.
//

#import "ViewController.h"
#import "MomentsVC.h"

@interface ViewController ()
{
    UIButton * btn;
}
@end

@implementation ViewController
- (IBAction)btnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Moments" bundle:[NSBundle mainBundle]];
    MomentsVC *mvc = [storyboard instantiateViewControllerWithIdentifier:@"Moments"];
    
    [self.navigationController pushViewController:mvc animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(100, 100, 200, 40);
    [btn setTitle:@"WeChatMoment" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
